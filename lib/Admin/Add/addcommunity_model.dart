import 'addcommunity_widget.dart' show AddCommunityWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';


class AddcommunityModel extends FlutterFlowModel<AddCommunityWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Headline widget.
  FocusNode? headlineFocusNode;
  TextEditingController? headlineController;
  String? Function(BuildContext, String?)? headlineControllerValidator;
  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  // State field(s) for Links widget.
  FocusNode? linksFocusNode;
  TextEditingController? linksController;
  String? Function(BuildContext, String?)? linksControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    headlineFocusNode?.dispose();
    headlineController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    linksFocusNode?.dispose();
    linksController?.dispose();
  }
}
