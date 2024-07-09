import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/About_us/about_us_widget.dart';
import 'package:my_app/Community/community_widget.dart';
import 'package:my_app/Explore/camera.dart';
import 'package:my_app/Explore/explore_widget.dart';
import 'package:my_app/GEHU/gehu_widget.dart';
import 'package:my_app/Home/home_widget.dart';
// import 'package:my_app/MapPg/map_pg_widget.dart';
import 'package:my_app/MapPg/screens/map_page.dart';
import 'package:my_app/Profile/profile_widget.dart';
import 'package:my_app/User_provider.dart';
import 'package:my_app/auth_Create/auth_create_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState()=>_MainScreenState();

}

class _MainScreenState extends State<MainScreen>{
  int _pageindex=0;

  List<Widget> _pages=[
    HomeWidget(),
    CollegeApp(),
    ProfileWidget(),
  ];
  
   final scaffoldKey = GlobalKey<ScaffoldState>();
 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      // onTap: () => _model.unfocusNode.canRequestFocus
      //     ? FocusScope.of(context).requestFocus(_model.unfocusNode)
      //     : FocusScope.of(context).unfocus(),
      // child: Scaffold(
         key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 100,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(9, 66, 0, 0),
                            child: FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderRadius: 20,
                              borderWidth: 1,
                              buttonSize: 40,
                              fillColor: FlutterFlowTheme.of(context).alternate,
                              icon: FaIcon(
                                FontAwesomeIcons.angleLeft,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24,
                              ),
                              onPressed: () async {
                                if (scaffoldKey.currentState!.isDrawerOpen ||
                                    scaffoldKey.currentState!.isEndDrawerOpen) {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 2),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //context.pushNamed('Community');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CommunityWidget()),
                          );
                        },
                        child: Container(
                          width: 0,
                          height: 65,
                          constraints: BoxConstraints(
                            maxWidth: 221,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(17),
                            shape: BoxShape.rectangle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Text(
                              'Community',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 2),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        // onTap: () async {
                         
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const MapPage()),
                        //   );
                        // },
                        child: Container(
                          width: 0,
                          height: 65,
                          constraints: BoxConstraints(
                            maxWidth: 221,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(17),
                            shape: BoxShape.rectangle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Text(
                              'Map',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 2),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //context.pushNamed('About_Us');
                          // context.pushNamed('About_Us');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExploreWidget()),
                          );
                        },
                        child: Container(
                          width: 0,
                          height: 65,
                          constraints: BoxConstraints(
                            maxWidth: 221,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(17),
                            shape: BoxShape.rectangle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Text(
                              'Explore',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 2),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //context.pushNamed('About_Us');
                          // context.pushNamed('About_Us');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutUsWidget()),
                          );
                        },
                        child: Container(
                          width: 0,
                          height: 65,
                          constraints: BoxConstraints(
                            maxWidth: 221,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(17),
                            shape: BoxShape.rectangle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Text(
                              'About Us',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 2),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          //context.pushNamed('auth_Create');
                          // context.pushNamed('auth_Create');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AuthCreateWidget()),
                          );
                        },
                        child: Container(
                          width: 0,
                          height: 65,
                          constraints: BoxConstraints(
                            maxWidth: 221,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(17),
                            shape: BoxShape.rectangle,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(-0.9, 0),
                            child: Text(
                              'LogOut',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 6, 0, 6),
            child: Container(
              width: 93,
              height: 233,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  width: 2,
                ),
              ),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: 20,
                borderWidth: 1,
                buttonSize: 40,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                icon: FaIcon(
                  FontAwesomeIcons.alignJustify,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24,
                ),
                onPressed: () async {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 20,
                buttonSize: 40,
                icon: Icon(
                  Icons.notifications_none,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24,
                ),
                onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageindex,
        onTap: (value){
          setState(() {
            _pageindex=value;
          });
        },
        backgroundColor:FlutterFlowTheme.of(context).secondaryBackground,
        unselectedItemColor: FlutterFlowTheme.of(context).accent1,
        selectedItemColor: FlutterFlowTheme.of(context).primary,
        items: [BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.circle_grid_hex_fill),
              label: 'Gehu',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
      ), 
      body: _pages[_pageindex],
        
      );
  }

}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(currentUser?.email)
            .collection('inbox')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
          }

          final messages = snapshot.data?.docs;

          if (messages == null || messages.isEmpty) {
            return Center(child: Text('No messages', style: TextStyle(color: Colors.white)));
          }

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index].data() as Map<String, dynamic>;
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(message['senderId'])
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Card(
                      color: Colors.grey[850],
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(message['message'], style: TextStyle(color: Colors.white)),
                        subtitle: Text('From: ${message['senderId']}', style: TextStyle(color: Colors.grey)),
                        trailing: Text(
                          _formatTimestamp(message['timestamp']),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  if (userSnapshot.hasError) {
                    return Card(
                      color: Colors.grey[850],
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(message['message'], style: TextStyle(color: Colors.white)),
                        subtitle: Text('From: ${message['senderId']}', style: TextStyle(color: Colors.grey)),
                        trailing: Text(
                          _formatTimestamp(message['timestamp']),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  final userData = userSnapshot.data?.data() as Map<String, dynamic>?;

                  if (userData == null) {
                    return Card(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(message['message'], style: TextStyle(color: Colors.white)),
                        subtitle: Text('From: ${message['senderId']}', style: TextStyle(color: Colors.grey)),
                        trailing: Text(
                          _formatTimestamp(message['timestamp']),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }

                  return Card(
                    color: Colors.grey[850],
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(message['message'], style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        'From: ${userData['username']}, ${userData['course']}, ${userData['semester']}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Text(
                        _formatTimestamp(message['timestamp']),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final dateFormat = DateFormat('MMM d, yyyy, hh:mm a'); // Example: May 27, 2024, 05:26 PM
    return dateFormat.format(dateTime);
  }
}