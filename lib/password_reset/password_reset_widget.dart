// import '/auth/firebase_auth/auth_util.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;

import 'password_reset_model.dart';
export 'password_reset_model.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset>
    with TickerProviderStateMixin {
  late AuthLoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(0, 140),
          end: Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(0.9, 0.9),
          end: Offset(1, 1),
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(-0.349, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthLoginModel());
  }

  @override
  void dispose() {
    _model.dispose();
    _emailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  // @override
  // void dispose(){
  //   _emailController.dispose();
  //   super.dispose();
  // }


  Future passwordreset() async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Password reset link sent'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to login page after clicking "OK"
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthCreateWidget(),
                  ),
                ); // Navigate to login page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } on FirebaseAuthException catch (e) {
    print(e);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          alignment: AlignmentDirectional(0, -1),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: 570,
                  maxHeight: 355,
                ),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reset',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).displaySmall,
                          ),
                          Text(
                            'Password',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 35,
                                ),
                          ),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                          //   child: Text(
                          //     'Reset Passowrd Here',
                          //     textAlign: TextAlign.start,
                          //     style: FlutterFlowTheme.of(context).labelLarge,
                          //   ),
                          // ),
                          Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    passwordreset();
                  }
                },
                child: Text('Confirm',
                style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 255, 132),
            ), // Set background color to grey
          ),
              ),
            ],
          ),
        ),
                         
                                    ],
                                    
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // ],

                      ),
                    ),
                  ),
                ),
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation']!
                  );
           
  }
}
