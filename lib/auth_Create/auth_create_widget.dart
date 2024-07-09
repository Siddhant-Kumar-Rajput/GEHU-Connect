//import '/auth/firebase_auth/auth_util.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Admin/Login/admin_login_widget.dart';
import 'package:my_app/User_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Home/home_widget.dart' show HomeWidget;
import 'package:my_app/password_reset/password_reset_widget.dart' show AuthLoginWidget, PasswordReset;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../global/common/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/mainscreen.dart';

import 'package:my_app/auth_create/firebase_auth_implementation/firebase_auth_services.dart';


import 'auth_create_model.dart';
export 'auth_create_model.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]
  );





class AuthCreateWidget extends StatefulWidget {
  const AuthCreateWidget({super.key});

  @override
  State<AuthCreateWidget> createState() => _AuthCreateWidgetState();
}

class _AuthCreateWidgetState extends State<AuthCreateWidget>
    with TickerProviderStateMixin {
  late AuthCreateModel _model;
  late GoogleSignInAccount currentUser;
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool isSigningUp = true;

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
          begin: Offset(0, -140),
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
          begin: Offset(0.349, 0),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((account){
      setState(() {
      currentUser = account! ;
      });
      if(currentUser!=null){
        print("is already authenticated");
      }
    });
      _googleSignIn.signInSilently() ;






    _model = createModel(context, () => AuthCreateModel());

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
  }


  Future<void> handleSignIn() async{
    try{
      await _googleSignIn.signIn();
    }catch(error){
        print("Sign in error : "+error.toString()) ;
    } 
  }
  Future<void> handleSignOut() => _googleSignIn.disconnect();





  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: 570,
                maxHeight: 625,
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
                          'GEHU Connect',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 35,
                                  ),
                        ),
                        Text(
                          'Let\'s Login',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).displaySmall,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                          child: Text(
                            'Students/Faculty',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context).labelLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.emailAddressController,
                              focusNode: _model.emailAddressFocusNode,
                              autofocus: true,
                              autofillHints: [AutofillHints.email],
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    FlutterFlowTheme.of(context).labelLarge,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
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
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context).bodyLarge,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model.emailAddressControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.passwordController,
                              focusNode: _model.passwordFocusNode,
                              autofocus: true,
                              autofillHints: [AutofillHints.password],
                              obscureText: !_model.passwordVisibility,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle:
                                    FlutterFlowTheme.of(context).labelLarge,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
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
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => _model.passwordVisibility =
                                        !_model.passwordVisibility,
                                  ),
                                  focusNode: FocusNode(skipTraversal: true),
                                  child: Icon(
                                    _model.passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24,
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyLarge,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model.passwordControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _login();
                              // context.pushNamed('Home');
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const HomeWidget()),
                              // );
                            },
                            text: 'Login',
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
                        ),
                        
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // context.pushNamed(
                                //   'auth_Login',
                                //   extra: <String, dynamic>{
                                //      kTransitionInfoKey: TransitionInfo(
                                //        hasTransition: true,
                                //        transitionType: PageTransitionType.fade,
                                //        duration: Duration(milliseconds: 200),
                                //      ),
                                //   },
                                // );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PasswordReset()),
                                );
                              },
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Forgot Password ? ',
                                      style: TextStyle(),
                                    ),
                                    TextSpan(
                                      text: 'Reset Here',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    )
                                    
                                  ],
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
  //                               ),
  //                             ),
                              
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),

),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // context.pushNamed(
                              //   'AdminLogin',
                              //   extra: <String, dynamic>{
                              //     kTransitionInfoKey: TransitionInfo(
                              //       hasTransition: true,
                              //       transitionType: PageTransitionType.fade,
                              //       duration: Duration(milliseconds: 200),
                              //     ),
                              //   },
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminLoginWidget()),
                                );
                            },
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Admin : ',
                                    style: TextStyle(),
                                  ),
                                  TextSpan(
                                    text: 'Login here',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
                          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
          ),
        ),
      ),
    )
    );
  }


  void _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _model.emailAddressController.text,
        password: _model.passwordController.text,
      );
      
      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        throw 'User not authenticated or email not verified';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid credentials. ${e.toString()}'),
      ));
    }
  }
  

}

