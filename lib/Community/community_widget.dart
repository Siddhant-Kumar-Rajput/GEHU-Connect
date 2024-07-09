
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flip_card/flip_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityWidget extends StatefulWidget {
  const CommunityWidget({Key? key}) : super(key: key);

  @override
  State<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Communities'),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('communities').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No communities found'));
            }
            return ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs.map((doc) {
                var community = doc.data() as Map<String, dynamic>;

                // Retrieve the icon data
                int iconCodePoint = community['icon'] ?? Icons.question_mark.codePoint;
                String fontFamily = community['fontFamily'] ?? 'MaterialIcons';

                return FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  front: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 410,
                      height: 173,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0.61),
                            child: Text(
                              community['name'] ?? '',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 30,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, -0.7),
                            child: Icon(
                              IconData(
                                iconCodePoint,
                                fontFamily: fontFamily,
                                fontPackage: fontFamily == 'FontAwesomeSolid' ? 'font_awesome_flutter' : null,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 80,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0.9),
                            child: Text(
                              'Tap for details',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  back: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 410,
                      height: 173,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.16, -0.66),
                            child: Text(
                              'Details of Community',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 30,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0.73),
                            child: FFButtonWidget(
                              onPressed: () {
                                // Navigate to the community link
                                // You can use a package like url_launcher to open the link
                                print('Navigating to ${community['link']}');
                              },
                              text: 'Join Now',
                              options: FFButtonOptions(
                                height: 40,
                                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                    ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}