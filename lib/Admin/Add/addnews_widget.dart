import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Admin/Home/home_page_widget.dart';
import 'package:provider/provider.dart';

import 'addnews_model.dart';
export 'addnews_model.dart';

class AddnewsWidget extends StatefulWidget {
  const AddnewsWidget({super.key});

  @override
  State<AddnewsWidget> createState() => _AddnewsWidgetState();
}

class _AddnewsWidgetState extends State<AddnewsWidget> {

final _formKey = GlobalKey<FormState>();
  final _headlineController = TextEditingController();
  final _detailsController = TextEditingController();
  final _linksController = TextEditingController();
  final _imageController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newsItem = {
        'headline': _headlineController.text,
        'details': _detailsController.text,
        'links': _linksController.text,
        'image': _imageController.text,
        'time': DateTime.now().toString(),
      };
      await FirebaseFirestore.instance.collection('news').add(newsItem);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('News Uploaded')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      // appBar: Title(
      //   color: FlutterFlowTheme.of(context).primary, ,
      //   child: Text("Add News"),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _headlineController,
                decoration: InputDecoration(
                  labelText: 'Headline',
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
                    return 'Please enter a headline';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _detailsController,
                decoration: InputDecoration(
                  labelText: 'Details',
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
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _linksController,
                decoration: InputDecoration(
                  labelText: 'Links',
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
              SizedBox(height: 30),
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: FFButtonWidget(
                  onPressed: _submitForm,
                  text: 'Add News',
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
            ],
          ),
        ),
      ),
    );
  }
}
