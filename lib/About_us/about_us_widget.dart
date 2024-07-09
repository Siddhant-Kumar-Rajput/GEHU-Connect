import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Explore/explore_widget.dart';
import 'package:my_app/Home/home_widget.dart';
import 'package:my_app/MapPg/screens/map_page.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Community/community_widget.dart' show CommunityWidget;
// import 'package:my_app/MapPg/map_pg_widget.dart' show MapPgWidget;
import 'package:my_app/About_us/about_us_widget.dart' show AboutUsWidget;
import 'package:my_app/password_reset/password_reset_widget.dart' show AuthLoginWidget;
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;

import 'about_us_model.dart';
export 'about_us_model.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({super.key});

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  late AboutUsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutUsModel());
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
        // title: Text('Text Users'),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white), // Change back button color to white
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TeamMemberCard(
              imagePath: 'assets/sir.jpg',
              name: 'Shashi Kumar Sharma',
              role: 'Mentor',
              details: 'Assistant Professor\nGraphic Era Hill University Bhimtal',
            ),
            SizedBox(height: 16),
            TeamMemberCard(
              imagePath: 'assets/me.jpg',
              name: 'Siddhant Kumar Rajput',
              role: 'Member/Student',
              details: 'B.Tech CSE\nGraphic Era Hill University Bhimtal',
            ),
            SizedBox(height: 16),
            TeamMemberCard(
              imagePath: 'assets/you.jpg',
              name: 'Rohit Singh Dobal',
              role: 'Member/Student',
              details: 'B.Tech CSE\nGraphic Era Hill University Bhimtal',
            ),
          ],
        ),
      ),
      );
  
  }
}






class TeamMemberCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String role;
  final String details;

  TeamMemberCard({
    required this.imagePath,
    required this.name,
    required this.role,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: FlutterFlowTheme.of(context).secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    details,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
