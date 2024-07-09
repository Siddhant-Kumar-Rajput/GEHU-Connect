import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'camera.dart';
import 'gallery.dart';

class Scanpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Maker'),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, 
                            backgroundColor: FlutterFlowTheme.of(context).primary,
                          ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraPage()),
                );
              },
              child: Text('Open Camera'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, 
                            backgroundColor: FlutterFlowTheme.of(context).primary,
                          ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              },
              child: Text('Open Gallery'),
            ),
          ],
        ),
     ),
    );
  }
}