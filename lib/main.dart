import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:my_app/Admin/Add/addnews_widget.dart';
import 'package:my_app/Admin/Home/home_page_widget.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/SplashScreen/splash_screen.dart';
// import 'auth/firebase_auth/firebase_user_provider.dart';
// import 'auth/firebase_auth/auth_util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/User_provider.dart';
import 'firebase_options.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:my_app/auth_create/firebase_auth_implementation/firebase_auth_services.dart';

// import 'flutter_flow/nav/nav.dart';
// import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );   

  usePathUrlStrategy();
  //await initFirebase();

  //await FlutterFlowTheme.initialize();

  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
