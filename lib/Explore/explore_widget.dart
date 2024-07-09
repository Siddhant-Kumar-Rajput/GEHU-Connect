import 'package:file_picker/file_picker.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Explore/convert.dart';
import 'package:my_app/Explore/scan.dart';
import 'package:my_app/Home/home_widget.dart';
import 'package:my_app/MapPg/screens/map_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Community/community_widget.dart' show CommunityWidget;
// import 'package:my_app/MapPg/map_pg_widget.dart' show MapPgWidget;
import 'package:my_app/About_us/about_us_widget.dart' show AboutUsWidget;
import 'package:my_app/Explore/camera.dart';
import 'package:my_app/password_reset/password_reset_widget.dart' show AuthLoginWidget;
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;

import 'explore_model.dart';
export 'explore_model.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({super.key});

  @override
  State<ExploreWidget> createState() => ExploreWidgetState();
}

class ExploreWidgetState extends State<ExploreWidget> {
  late ExploreModel _model;
    File? selectedFile;
  String? conversionType;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExploreModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FFButtonWidget(
            //               onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => Scanpage(),
            //             ),
            //           );
            //         },
            //               text: 'PDF Maker',
            //               options: FFButtonOptions(
            //                 height: 40,
            //                 padding:
            //                     EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            //                 iconPadding:
            //                     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            //                 color: FlutterFlowTheme.of(context).primary,
            //                 textStyle: FlutterFlowTheme.of(context)
            //                     .titleSmall
            //                     .override(
            //                       fontFamily: 'Readex Pro',
            //                       color: Colors.white,
            //                       letterSpacing: 0,
            //                     ),
            //                 elevation: 3,
            //                 borderSide: BorderSide(
            //                   color: Colors.transparent,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             ),
            //             SizedBox(height: 30),
            // FFButtonWidget(
            //               onPressed: () => pickFile('pdf_to_word'),
            //               text: 'Convert PDF to Word',
            //               options: FFButtonOptions(
            //                 height: 40,
            //                 padding:
            //                     EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            //                 iconPadding:
            //                     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            //                 color: FlutterFlowTheme.of(context).primary,
            //                 textStyle: FlutterFlowTheme.of(context)
            //                     .titleSmall
            //                     .override(
            //                       fontFamily: 'Readex Pro',
            //                       color: Colors.white,
            //                       letterSpacing: 0,
            //                     ),
            //                 elevation: 3,
            //                 borderSide: BorderSide(
            //                   color: Colors.transparent,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             ),
            //             SizedBox(height: 30),
            //             FFButtonWidget(
            //               onPressed: () => pickFile('word_to_pdf'),
            //               text: 'Convert Word to PDF',
            //               options: FFButtonOptions(
            //                 height: 40,
            //                 padding:
            //                     EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            //                 iconPadding:
            //                     EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            //                 color: FlutterFlowTheme.of(context).primary,
            //                 textStyle: FlutterFlowTheme.of(context)
            //                     .titleSmall
            //                     .override(
            //                       fontFamily: 'Readex Pro',
            //                       color: Colors.white,
            //                       letterSpacing: 0,
            //                     ),
            //                 elevation: 3,
            //                 borderSide: BorderSide(
            //                   color: Colors.transparent,
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             ),
            ElevatedButton(
              onPressed: () => pickFile('pdf_to_word'),
              child: Text("Convert PDF to Word"),
            ),
            ElevatedButton(
              onPressed: () => pickFile('word_to_pdf'),
              child: Text("Convert Word to PDF"),
            ),
          ],
        ),
      ),
      );
  }
  // Future<void> pickFile(String type) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: type == 'pdf_to_word' ? ['pdf'] : ['doc', 'docx'],
  //   );

  //   if (result != null && result.files.isNotEmpty) {
  //     setState(() {
  //       selectedFile = File(result.files.single.path!);
  //       conversionType = type;
  //     });

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ConvertScreen(
  //           file: selectedFile!,
  //           conversionType: conversionType!,
  //         ),
  //       ),
  //     );
  //   }
  // }
  Future<void> pickFile(String type) async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: type == 'pdf_to_word' ? ['pdf'] : ['doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      String? filePath = result.files.single.path;

      if (filePath != null) {
        setState(() {
          selectedFile = File(filePath);
          conversionType = type;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConvertScreen(
              file: selectedFile!,
              conversionType: conversionType!,
            ),
          ),
        );
      } else {
        // Handle the case where the file path is null
        // You can show a message to the user or log the error
        print('Error: File path is null.');
      }
    } else {
      // Handle the case where no file was selected
      // You can show a message to the user or log the error
      print('No file selected.');
    }
  } catch (e) {
    // Handle any other errors that might occur
    print('An error occurred: $e');
  }
}

}
