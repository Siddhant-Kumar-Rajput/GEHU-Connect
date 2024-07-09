import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:my_app/Admin/Manage/manage_news_widget.dart' show ManageNewsPage;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ManageNewsModel extends FlutterFlowModel<ManageNewsPage> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
