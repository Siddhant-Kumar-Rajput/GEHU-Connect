import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class EditCommunityDialog extends StatefulWidget {
  final DocumentSnapshot newsItem;

  EditCommunityDialog({required this.newsItem});

  @override
  _EditCommunityDialogState createState() => _EditCommunityDialogState();
}

class _EditCommunityDialogState extends State<EditCommunityDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _linkController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.newsItem['name']);
    _linkController = TextEditingController(text: widget.newsItem['link']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Community'),
      contentTextStyle: TextStyle(color: FlutterFlowTheme.of(context).primary,),
      titleTextStyle: TextStyle(color: FlutterFlowTheme.of(context).primary,),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'name',
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
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(
                  labelText: 'link',
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
                    return 'Please enter link';
                  }
                  return null;
                },
              ),
             SizedBox(height: 10),

              
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
                  .collection('communities')
                  .doc(widget.newsItem.id)
                  .update({
                'name': _nameController.text,
                'link': _linkController.text,
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
