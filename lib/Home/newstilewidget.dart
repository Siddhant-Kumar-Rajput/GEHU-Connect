import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/Home/home_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTilesWidget extends StatefulWidget {
  @override
  _NewsTilesWidgetState createState() => _NewsTilesWidgetState();
}

class _NewsTilesWidgetState extends State<NewsTilesWidget> {
  final PageController _pageController = PageController();
  Timer? _timer;
   int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = _pageController.page!.round() + 1;
        if (nextPage < _pageController.position.maxScrollExtent) {
          _pageController.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

 void _nextPage() {
    int nextPage = _currentPage + 1;
    if (nextPage >= _pageController.positions.length) {
      nextPage = 0;
    }
    _pageController.animateToPage(
      nextPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _currentPage = nextPage;
  }

  void _previousPage() {
    int previousPage = _currentPage - 1;
    if (previousPage < 0) {
      previousPage = _pageController.positions.length - 1;
    }
    _pageController.animateToPage(
      previousPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _currentPage = previousPage;
  }

@override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var newsList = snapshot.data!.docs;
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  var newsItem = newsList[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: NewsTile(newsItem: newsItem),
                    ),
                  );
                },
                onPageChanged: (index) {
                  _currentPage = index;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _previousPage,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _nextPage,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class NewsTile extends StatelessWidget {
  final Map<String, dynamic> newsItem;

  NewsTile({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      
      height: 240,
      child: Card(
        
        color: FlutterFlowTheme.of(context).alternate,
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                newsItem['image'] ?? '',
                width:   double.infinity,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print("Error loading image: $error"); // Debug print
                  return Icon(Icons.error);
                },
              ),
              SizedBox(height: 8),
              Text(
                newsItem['headline'] ?? '',
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white 
                  ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                             
                ),
              SizedBox(height: 4),
              Expanded(
                child: Text(
                  newsItem['details'] ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(newsItem: newsItem),
                    ),
                  );
                },
                child: Text(
                  '...more',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Published at: ${newsItem['time']}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class NewsDetailPage extends StatelessWidget {
  final Map<String, dynamic> newsItem;

  NewsDetailPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: Image.network(
                  // width: double.infinity,
                  newsItem['image'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 16),
              Text(
                newsItem['headline'] ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),
              ),
              SizedBox(height: 16),
              Text(newsItem['details'] ?? '',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey,),
              ),
              if (newsItem['links'] != null && newsItem['links'].isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      _launchURL(newsItem['links']);
                    },
                    child: Text(
                      'Link: Click here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
