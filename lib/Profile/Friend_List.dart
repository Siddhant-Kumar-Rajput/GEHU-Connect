
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:my_app/Profile/View_Profile.dart';

class FriendsListWidget extends StatefulWidget {
  @override
  _FriendsListWidgetState createState() => _FriendsListWidgetState();
}

class _FriendsListWidgetState extends State<FriendsListWidget> {
  String? selectedCourse;
  String? selectedSemester;
  String searchQuery = "";
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    // Fetch the current user ID
    currentUserId = FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Text Users'),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white), // Change back button color to white
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Course',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).alternate,
                        ),
                        dropdownColor: FlutterFlowTheme.of(context).alternate,
                        value: selectedCourse,
                        items: ['B.Tech', 'BBS', 'B.Com'].map((course) {
                          return DropdownMenuItem(
                            value: course,
                            child: Text(course, style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCourse = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Semester',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor:  FlutterFlowTheme.of(context).alternate,
                        ),
                        dropdownColor: FlutterFlowTheme.of(context).alternate,
                        value: selectedSemester,
                        items: List.generate(8, (index) => (index + 1).toString()).map((semester) {
                          return DropdownMenuItem(
                            value: semester,
                            child: Text(semester, style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSemester = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedCourse = null;
                          selectedSemester = null;
                        });
                      },
                      child: Text('Clear Filters', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary,),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary,),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).alternate,
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: FlutterFlowTheme.of(context).primary,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No users found', style: TextStyle(color: Colors.white)));
                }

                var users = snapshot.data!.docs.where((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  var matchesCourse = selectedCourse == null || data['course'] == selectedCourse;
                  var matchesSemester = selectedSemester == null || data['semester'] == selectedSemester;
                  var matchesSearch = searchQuery.isEmpty || data['username'].toLowerCase().contains(searchQuery);
                  var isNotCurrentUser = doc.id != currentUserId;
                  return matchesCourse && matchesSemester && matchesSearch && isNotCurrentUser;
                }).toList();

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var user = users[index].data() as Map<String, dynamic>;
                    return Card(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(user['profilePicture'] ?? ''),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(user['username'], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        subtitle: Text('${user['course'] ?? 'N/A'}\n ${user['semester'] ?? 'N/A'}', style: TextStyle(color: Colors.white)),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, 
                            backgroundColor: FlutterFlowTheme.of(context).primary,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewProfileWidget(userId: users[index].id),
                              ),
                            );
                          },
                          child: Text('View Profile', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
