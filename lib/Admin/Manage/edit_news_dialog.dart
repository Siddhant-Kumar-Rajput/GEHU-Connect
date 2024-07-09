import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class EditNewsDialog extends StatefulWidget {
  final DocumentSnapshot newsItem;

  EditNewsDialog({required this.newsItem});

  @override
  _EditNewsDialogState createState() => _EditNewsDialogState();
}

class _EditNewsDialogState extends State<EditNewsDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _headlineController;
  late TextEditingController _detailsController;
  late TextEditingController _imageController;
  late TextEditingController _linksController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _headlineController = TextEditingController(text: widget.newsItem['headline']);
    _detailsController = TextEditingController(text: widget.newsItem['details']);
    _imageController = TextEditingController(text: widget.newsItem['image']);
    _linksController = TextEditingController(text: widget.newsItem['links']);
    _timeController = TextEditingController(text: widget.newsItem['time']);
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _detailsController.dispose();
    _imageController.dispose();
    _linksController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit News'),
      contentTextStyle: TextStyle(color: FlutterFlowTheme.of(context).primary,),
      titleTextStyle: TextStyle(color: FlutterFlowTheme.of(context).primary,),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter a headline';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
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
                  cursorColor: FlutterFlowTheme.of(context).primary,                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter details';
                  }
                  return null;
                },
              ),
             SizedBox(height: 10),

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
              SizedBox(height: 10),

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
              SizedBox(height: 10),

              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
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
            ],
          ),
        ),
      ),
      actions: [
        
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel',
          style: TextStyle(color: Colors.white),),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 75, 75, 75),
            ), // Set background color to grey
          ),
        ),
        ElevatedButton(
          
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FirebaseFirestore.instance
                  .collection('news')
                  .doc(widget.newsItem.id)
                  .update({
                'headline': _headlineController.text,
                'details': _detailsController.text,
                'image': _imageController.text,
                'links': _linksController.text,
                'time': _timeController.text,
              }).then((_) {
                Navigator.pop(context);
              });
            }
          },
          child: Text('Save',
          style: TextStyle(color: Colors.white),),
          
          
           style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 255, 132),
            ), // Set background color to grey
          ),
          
        ),
      ],
    );
  }
}
