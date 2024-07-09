// //import '/backend/api_requests/api_calls.dart';
// import 'package:flutterflow_ui/flutterflow_ui.dart';
// import 'home_widget.dart' show HomeWidget;
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class HomeModel extends FlutterFlowModel<HomeWidget> {
//   ///  State fields for stateful widgets in this page.

//   final unfocusNode = FocusNode();

//   /// Initialization and disposal methods.

//   @override
//   void initState(BuildContext context) {}

//   @override
//   void dispose() {
//     unfocusNode.dispose();
//   }

//   /// Action blocks are added here.

//   /// Additional helper methods are added here.
// }
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 1;

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
