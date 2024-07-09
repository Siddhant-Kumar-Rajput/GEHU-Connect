import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'gehu_widget.dart' show CollegeApp;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GehuModel extends FlutterFlowModel<CollegeApp> {
  ///  Local state fields for this page.

  String? inputContent = '';

  dynamic chatHistory;

  bool aiResponding = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
