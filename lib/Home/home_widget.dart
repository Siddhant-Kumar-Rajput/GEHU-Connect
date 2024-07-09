import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Explore/explore_widget.dart';
import 'package:my_app/GEHU/gehu_widget.dart';
import 'package:my_app/Profile/profile_widget.dart';
import 'package:my_app/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Community/community_widget.dart' show CommunityWidget;
// import 'package:my_app/MapPg/map_pg_widget.dart' show MapPgWidget;
import 'package:my_app/About_us/about_us_widget.dart' show AboutUsWidget;
import 'package:my_app/password_reset/password_reset_widget.dart' show AuthLoginWidget;
import 'package:my_app/Home/weather_service.dart';
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;
import 'package:my_app/Home/chat.dart';

import 'home_model.dart';
import 'newstilewidget.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;
  int _selectedIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    MainScreen();
    _model = createModel(context, () => HomeModel());
  }

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
        floatingActionButton: FloatingActionButton(
          // child: Icon(Icons.chat),
          // label: Text("Chat!"),
          onPressed: () {
             Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chat()));
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8,
          child: Icon(
            Icons.chat,
            color: FlutterFlowTheme.of(context).info,
            size: 24,
          ),
        ),
        //
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 10, 0, 0),
                  child: Text(
                    'Stay up to date with the latest news below.',
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
                
                SizedBox(height: 10),
            Container(
              
              height: 270,  // Set the height for the news tiles
              child: NewsTilesWidget(),  // Include the NewsTilesWidget here
            ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                  child: Text(
                    'Weather Today',
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                  child: Container(
                    width: double.infinity,
                    height: 286,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(
          4,
        ),
                    ),
                    child: WeatherServices(),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
       
      ),
    );
  }
//     
}