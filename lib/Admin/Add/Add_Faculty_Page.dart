  import 'dart:io';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddFacultyPage extends StatefulWidget {
  @override
  _AddFacultyPageState createState() => _AddFacultyPageState();
}

class _AddFacultyPageState extends State<AddFacultyPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _imageController = TextEditingController();
  late String _selectedDesignation;
  late String _selectedDepartment;
  List<String> _designation = ["","Professor", "Ast. Professor"];
  List<String> _department = ["","CSE", "ECE", "CE", "ME"];

  @override
  void initState() {
    super.initState();
    _selectedDesignation = (_designation.isNotEmpty ? _designation.first : null)!;
    _selectedDepartment = (_department.isNotEmpty ? _department.first : null)!;
  }

  //   Future<String> uploadImage() async {
  //   try {
  //     String fileName = path.basename(_imageFile!.path); // Use basename function
  //     firebase_storage.Reference firebaseStorageRef =
  //         firebase_storage.FirebaseStorage.instance.ref().child('profilePictures/$fileName');
  //     await firebaseStorageRef.putFile(File(_imageFile!.path));
  //     String imageUrl = await firebaseStorageRef.getDownloadURL();
  //     return imageUrl;
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     return '';
  //   }
  // }
//   Future<String> uploadImage() async {
//   try {
//     if (_imageFile != null) {
//       String fileName = path.basename(_imageFile!.path);
//       firebase_storage.Reference firebaseStorageRef =
//           firebase_storage.FirebaseStorage.instance.ref().child('profilePictures/$fileName');
//       await firebaseStorageRef.putFile(File(_imageFile!.path));
//       String imageUrl = await firebaseStorageRef.getDownloadURL();
//       return imageUrl;
//     } else {
//       return ''; // No image selected
//     }
//   } catch (e) {
//     print('Error uploading image: $e');
//     throw Exception('Failed to upload image');
//   }
// }


  // XFile? _imageFile;
  // void _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = pickedFile;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
            
            
          //     Container(
          //       width: 120,
          //       height: 120,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.grey[300],
          //       ),
          //       child: _imageFile == null
          //           ? Icon(Icons.person, size: 80, color: Colors.grey[600]) // Placeholder icon
          //           : ClipOval(
          //               child: Image.file(
          //                 File(_imageFile!.path),
          //                 width: 120,
          //                 height: 120,
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //     ),
              
            
          // SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: _pickImage,
          //   child: Text('Add Image'),
          // ),
              // TextFormField(
              //   controller: _usernameController,
              //   decoration: InputDecoration(labelText: 'Username'),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter username';
              //     }
              //     return null;
              //   },
              // ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle:FlutterFlowTheme.of(context).labelLarge,
                  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge,
                  cursorColor: FlutterFlowTheme.of(context).primary,
                  validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:FlutterFlowTheme.of(context).labelLarge,
                  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge,
                  cursorColor: FlutterFlowTheme.of(context).primary,
                  validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),


          

              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Contact',
                  labelStyle:FlutterFlowTheme.of(context).labelLarge,
                  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge,
                  cursorColor: FlutterFlowTheme.of(context).primary,
                  validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter contact';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),


              

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:FlutterFlowTheme.of(context).labelLarge,
                  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge,
                  cursorColor: FlutterFlowTheme.of(context).primary,
                  validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),


              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  labelStyle:FlutterFlowTheme.of(context).labelLarge,
                  enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  style: FlutterFlowTheme.of(context).bodyLarge,
                  cursorColor: FlutterFlowTheme.of(context).primary,
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                dropdownColor: FlutterFlowTheme.of(context).alternate,
                value: _selectedDesignation,
                items: _designation.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course,style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDesignation = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Designation' , labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null) {
                    return 'Please select designation';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField(
                value: _selectedDepartment,
                dropdownColor: FlutterFlowTheme.of(context).alternate,
                items: _department.map((semester) {
                  return DropdownMenuItem(
                    value: semester,
                    child: Text(semester,style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Department', labelStyle: TextStyle(color: Colors.white)),
                validator: (value) {
                  if (value == null) {
                    return 'Please select department';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: FFButtonWidget(
                  onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addUser();
                  }
                },
                  text: 'Add Faculty',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                    elevation: 3,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              // ElevatedButton(
                // onPressed: () {
                //   if (_formKey.currentState!.validate()) {
                //     _addUser();
                //   }
                // },
              //   child: Text('Add User'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // String imageUrl = await uploadImage();

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set({
        'username': _usernameController.text,
        'email': _emailController.text,
        'contact': _contactController.text,
        'course': _selectedDesignation,
        'semester': _selectedDepartment,
        'profilePicture': _imageController.text,
      });
    
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User added successfully'),
      ));

      // Clear text field controllers
      _usernameController.clear();
      _emailController.clear();
      _contactController.clear();
      _passwordController.clear();
      _imageController.clear();
      // setState(() {
      //   _selectedCourse = null;
      //   _selectedSemester = null;
      // });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }
}
