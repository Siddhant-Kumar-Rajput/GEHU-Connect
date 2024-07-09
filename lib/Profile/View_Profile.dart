import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:my_app/User_provider.dart';
import 'package:provider/provider.dart';

class ViewProfileWidget extends StatelessWidget {
  final String userId;
  final bool isFriendProfile;

  ViewProfileWidget({required this.userId, this.isFriendProfile = false});

  void _showMessageDialog(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return AlertDialog(
  backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
  title: Text('Enter the message', style: TextStyle(color: Colors.white)),
  content: TextField(
    controller: messageController,
    style: TextStyle(color: Colors.white), // Text color
    cursorColor: FlutterFlowTheme.of(context).primary, // Blinker color
    decoration: InputDecoration(
      hintText: 'Type your message here',
      hintStyle: TextStyle(color: Colors.grey), // Hint text color
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary), // Underline color when not focused
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary), // Underline color when focused
      ),
    ),
  ),
  actions: [
    TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, // Ensure the text color is white
      ),
      child: Text('Cancel', style: TextStyle(color: FlutterFlowTheme.of(context).primary)),
    ),
    ElevatedButton(
      onPressed: () {
        _sendMessage(context, messageController.text);
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: FlutterFlowTheme.of(context).primary, // Button color
      ),
      child: Text('Send', style: TextStyle(color: Colors.white)), // Text color
    ),
  ],
);

      },
    );
  }

  // void _sendMessage(BuildContext context, String message) {
  //   final currentUser = Provider.of<UserProvider>(context, listen: false).user;

  //   if (currentUser != null && message.isNotEmpty) {
  //     FirebaseFirestore.instance.collection('messages').add({
  //       'senderId': currentUser.uid,
  //       'receiverId': userId,
  //       'message': message,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //   }
  // }

  //  void _sendMessage(BuildContext context, String message) {
  //   final currentUser = Provider.of<UserProvider>(context, listen: false).user;

  //   if (currentUser != null && message.isNotEmpty) {
  //     FirebaseFirestore.instance.collection('messages').doc(userId).collection('inbox').add({
  //       'senderId': currentUser.uid,
  //       'receiverId': userId,
  //       'message': message,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //   }
  // }

  void _sendMessage(BuildContext context, String message) {
  final currentUser = Provider.of<UserProvider>(context, listen: false).user;

  if (currentUser != null && message.isNotEmpty) {
    FirebaseFirestore.instance
        .collection('messages')
        .doc(userId) // Receiver's email is used as document ID
        .collection('inbox')
        .add({
      'senderId': currentUser.email, // Use sender's email as sender ID
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Profile'),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>?;

          if (userData == null) {
            return Center(child: Text('No user data found'));
          }

          var profileImageUrl = '${userData['profilePicture']}';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(profileImageUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${userData['username']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${userData['email']}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      leading: Icon(Icons.phone,  color: Colors.white),
                      title:  Text(
                        'Student ID',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${userData['contact'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      leading: Icon(Icons.book, color: Colors.white),
                      // title: Text(
                      //   'Course',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      title: Text(
                        '${userData['course'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: ListTile(
                      leading: Icon(Icons.school, color: Colors.white),
                      
                      title: Text(
                        '${userData['semester'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  if (!isFriendProfile)
                    FFButtonWidget(
                            onPressed: () {
                        _showMessageDialog(context);
                      },
                            text: 'Send Message',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 44,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
