import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'edit_news_dialog.dart';

class ManageNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30), // Header space
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('news').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var newsList = snapshot.data!.docs;
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: newsList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    var newsItem = newsList[index];
                    return Container(
                      color: FlutterFlowTheme.of(context).secondaryBackground, // Grey color for list item
                      child: ListTile(
                        title: Text(newsItem['headline'] ?? 'No headline'),
                        textColor: Colors.white,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: const Color.fromARGB(255, 0, 255, 8),
                              onPressed: () {
                                _showEditDialog(context, newsItem);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Color.fromARGB(255, 255, 0, 0),
                              onPressed: () {
                                _deleteNewsItem(newsItem.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, DocumentSnapshot newsItem) {
    showDialog(
      context: context,
      builder: (context) {
        return EditNewsDialog(newsItem: newsItem);
      },
    );
  }

  void _deleteNewsItem(String id) {
    FirebaseFirestore.instance.collection('news').doc(id).delete();
  }
}
