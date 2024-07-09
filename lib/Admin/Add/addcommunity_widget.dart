
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCommunityWidget extends StatefulWidget {
  const AddCommunityWidget({Key? key}) : super(key: key);

  @override
  _AddCommunityWidgetState createState() => _AddCommunityWidgetState();
}

class _AddCommunityWidgetState extends State<AddCommunityWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  String? _selectedIcon;

  final List<Map<String, dynamic>> _icons = [
    {'icon': FontAwesomeIcons.basketballBall, 'name': 'basketball'},
    {'icon': FontAwesomeIcons.laptopCode, 'name': 'laptopCode'},
    {'icon': Icons.camera_alt, 'name': 'cameraAlt'},
    // Add more icons as needed
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _addCommunity() async {
    if (_nameController.text.isEmpty || _linkController.text.isEmpty || _selectedIcon == null) {
      return;
    }

    final selectedIconData = _icons.firstWhere((icon) => icon['name'] == _selectedIcon);

    await FirebaseFirestore.instance.collection('communities').add({
      'name': _nameController.text,
      'link': _linkController.text,
      'icon': selectedIconData['icon'].codePoint,
      'fontFamily': selectedIconData['icon'].fontFamily,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
      TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Community Name',
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
                    return 'Please enter a community name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(
                  labelText: 'Link',
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
                    return 'Please enter a form link';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
      // TextField(
      //   controller: _nameController,
      //   decoration: InputDecoration(
      //     labelText: 'Community Name',
      //     filled: true,
      //     fillColor: FlutterFlowTheme.of(context).alternate,
      //     border: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.green),
      //     ),
      //   ),
      //   cursorColor: Colors.green,
      //   style: TextStyle(color: Colors.white),
      // ),
      // SizedBox(height: 10),
      // TextField(
      //   controller: _linkController,
      //   decoration: InputDecoration(
      //     labelText: 'Link',
      //     filled: true,
      //     fillColor: FlutterFlowTheme.of(context).alternate,
      //     border: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.green),
      //     ),
      //   ),
      //   cursorColor: Colors.green,
      //   style: TextStyle(color: Colors.white),
      // ),
      // SizedBox(height: 10),
      DropdownButton<String>(
        hint: Text('Select Icon', style: TextStyle(color: Colors.white)),
        value: _selectedIcon,
        dropdownColor: FlutterFlowTheme.of(context).alternate,
        onChanged: (String? newValue) {
          setState(() {
            _selectedIcon = newValue;
          });
        },
        items: _icons.map<DropdownMenuItem<String>>((Map<String, dynamic> iconData) {
          return DropdownMenuItem<String>(
            value: iconData['name'],
            child: Row(
              children: [
                Icon(iconData['icon'], color: Colors.white),
                SizedBox(width: 10),
                Text(iconData['name'], style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 20),
      // ElevatedButton(
      //   onPressed: _addCommunity,
      //   child: Text('Add Community', style: TextStyle(color: Colors.white)),
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: Colors.green,
      //   ),
      // ),
      FFButtonWidget(
                              onPressed: _addCommunity,
                              text: 'Add Community',
                              options: FFButtonOptions(
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
    ],
  ),
),
    );
  }
}
