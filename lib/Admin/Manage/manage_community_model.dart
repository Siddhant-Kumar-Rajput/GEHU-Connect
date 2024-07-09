import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'manage_community_widget.dart' show ManageCommunityWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ManageCommunityModel extends FlutterFlowModel<ManageCommunityWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
