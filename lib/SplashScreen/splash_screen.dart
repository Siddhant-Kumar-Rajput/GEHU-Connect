import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _bottomImageHeight = 0.0;
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Simulate the animation with a delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _bottomImageHeight =
            100.0; // Set to the desired height for the bottom image
        _logoOpacity = 1.0;
      });

      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                AuthCreateWidget(), // Replace with your login page widget
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Place items at the top and bottom
          children: <Widget>[
            Expanded(
              child: Center(
                child: AnimatedOpacity(
                  opacity: _logoOpacity,
                  duration: Duration(seconds: 1),
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.5, // Adjusted size
                    height: MediaQuery.of(context).size.width *
                        0.5, // Adjusted size
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/txt.png'), // Replace with your logo image asset
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Scrolling up bottom image
            AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                width: MediaQuery.of(context).size.width, // Adjusted size
                height: _bottomImageHeight,
                child: Image.asset(
                    'assets/clg.png') // Replace with your bottom image widget
                ),
          ],
        ),
      ),
    );
  }
}
