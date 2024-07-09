// import '/auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Explore/explore_widget.dart';
import 'package:my_app/GEHU/gehu_widget.dart';
import 'package:my_app/Home/home_widget.dart';
import 'package:my_app/Profile/Friend_List.dart';
import 'package:my_app/Profile/text_box.dart';
import 'package:my_app/User_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Community/community_widget.dart' show CommunityWidget;
// import 'package:my_app/MapPg/map_pg_widget.dart' show MapPgWidget;
import 'package:my_app/About_us/about_us_widget.dart' show AboutUsWidget;
import 'package:my_app/password_reset/password_reset_widget.dart' show AuthLoginWidget;
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;

import 'profile_model.dart';
export 'profile_model.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user?.email).get(),
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${user?.email}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white70,
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
                      leading: Icon(Icons.phone, color: Colors.white),
                      title: Text(
                        'Student ID',
                        style: TextStyle(
                          color: Colors.white70,
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
                      //     color: Colors.white70,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      title:Text(
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
                      // title: Text(
                      //   'Semester',
                      //   style: TextStyle(
                      //     color: Colors.white70,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      title: Text(
                        '${userData['semester'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  
                          FFButtonWidget(
                            onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendsListWidget(),
                        ),
                      );
                    },
                            text: 'Text Users',
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