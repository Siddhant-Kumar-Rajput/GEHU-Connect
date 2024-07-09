import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Explore/explore_widget.dart';
import 'package:my_app/GEHU/banner.dart';
import 'package:my_app/Home/home_widget.dart';
import 'package:my_app/Profile/profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Community/community_widget.dart' show CommunityWidget;
// import 'package:my_app/MapPg/map_pg_widget.dart' show MapPgWidget;
import 'package:my_app/About_us/about_us_widget.dart' show AboutUsWidget;
import 'package:my_app/password_reset/password_reset_widget.dart' show AuthLoginWidget;
import 'package:my_app/auth_Create/auth_create_widget.dart'
    show AuthCreateWidget;
import 'package:url_launcher/url_launcher.dart';

import 'gehu_model.dart';
export 'gehu_model.dart';

// class GehuWidget extends StatelessWidget {
//   const GehuWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(context).padding.bottom) ,
//             child: Column(children: [
//               BannerWidget()
//             ],),
//           ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() => runApp(CollegeApp());

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// void main() => runApp(CollegeApp());

// class CollegeApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CollegePage(),
//     );
//   }
// }

class CollegeApp extends StatelessWidget {
  final List<String> collegeImages = [
    'assets/clg1.jpeg',
    'assets/clg2.jpeg',
    'assets/clg3.jpeg',
    'assets/clg4.jpeg',
    'assets/clg5.jpeg',
  ];

  final List<String> adminImages = [
    'assets/President.png',
    'assets/VC.png',
    'assets/Director.png',
  ];

  final List<String> adminTitles = [
    'Prof. (Dr.) Kamal Ghanshala',
    'Prof. (Dr.) Sanjay Jasola',
    'Prof. (Col) A.K.Nair (Retd)',
  ];

  final List<String> adminRoles = [
    'President, Graphic Era Group of Institutions',
    'Vice Chancellor',
    'Director',
  ];

  final List<String> socialMediaLinks = [
    'https://m.facebook.com/gehubhimtal.official',
    'https://www.linkedin.com/school/graphicerahilluniversity/',
    'https://twitter.com/gehu_bhimtal',
    'https://www.instagram.com/gehubhimtal.official/',
    'https://www.youtube.com/GEHUDehradun',
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      // appBar: AppBar(
      //   title: Text('About Our College'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: collegeImages.length,
                  options: CarouselOptions(
                    autoPlay: true, // Auto play images
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 2), // Change image after 2 seconds
                  ),
                  itemBuilder: (context, index, _) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          collegeImages[index],
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Swipe to Explore More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'At the forefront of Quality Higher Education and Academic Excellence Graphic Era Hill University',
                style: TextStyle(
                  fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: FlutterFlowTheme.of(context).primary,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Founded in 2011, Graphic Era Hill University has its campus in Bhimtal, Uttarakhand, India, with the goal of providing world class-education with a clear focus on cutting-edge technologies, professional development of students, critical thinking and quality research. The University has achieved numerous milestones in its glorious past on the basis of its academic rigor, consistently Top Performing Students and Alumni and an immensely strong and qualified teaching fraternity.\n\nGraphic Era Hill University, Bhimtal Campus is located at the Kumaon foothills of the outer Himalayas amidst lush green tree cover, along the Sattal Road. It has been designed as a self contained community with academic and research facilities, laboratories, libraries and administrative offices all in the same campus.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Administration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: FlutterFlowTheme.of(context).primary),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: adminImages.length,
              itemBuilder: (context, index) {
                return Card(
                  
                color: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          adminImages[index],
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          adminTitles[index],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: FlutterFlowTheme.of(context).primary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          adminRoles[index],
                          style: TextStyle(fontSize: 14,color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _getAdminDetails(index),
                          style: TextStyle(fontSize: 14,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Follow Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: FlutterFlowTheme.of(context).primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    color: Colors.white,
                    onPressed: () {
                      _launchURL(socialMediaLinks[0]);
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    color: Colors.white,
                    onPressed: () {
                      _launchURL(socialMediaLinks[1]);
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.white,
                    onPressed: () {
                      _launchURL(socialMediaLinks[2]);
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    color: Colors.white,
                    onPressed: () {
                      _launchURL(socialMediaLinks[3]);
                    },
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.youtube),
                    color: Colors.white,
                    onPressed: () {
                      _launchURL(socialMediaLinks[4]);
                    },
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text(
            //     'Contact Us',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Text(
            //     'Phone: 08126107820\nEmail: contact@college.edu\nAddress: 123 College St, City, Country',
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getAdminDetails(int index) {
    switch (index) {
      case 0:
        return 'The Founder-President of the prestigious Graphic Era Group of Institutions is a renowned academician and edupreneur. Prof. Ghanshala still continues to take classes of every student of Computer Science that passes out of Graphic Era Group of Institutions, ensuring a high level of competence in the core subjects of Data Structures and Algorithms. His contribution in the field of research can be felt globally in USA, Canada, London, Paris, Germany, Denmark, Johannesburg, Turkey, Croatia and Thailand. Amongst many laurels, he has been conferred the ‘Uttarakhand Ratna, 2007’ for outstanding contribution to quality Technical and Higher education and the ‘Visionary Edupreneur of India Award, 2017’ by Hon’ble Former President of India, Mr. Pranab Mukherjee.';
      case 1:
        return 'Prof. Sanjay Jasola is the present Vice Chancellor of Graphic Era Hill University. He was the founding Vice Chancellor of the University, the position which he held from November 2011 to November 2021. Subsequently, he was appointed as the Director General of Graphic Era (Deemed to be) University contributing to its growth and success during his short stint from Nov 2021 to May 2023. Prior to joining Graphic Era, Prof. Jasola was Dean (Academics), Dean (School of ICT) in Gautam Buddha University, Greater NOIDA. He has three decades of experience in teaching, research and academic administration. He has also served as faculty member in Wawasan Open University, Penang, Malaysia and as Deputy Director in IGNOU, New Delhi. He has conducted Open Educational Resources (OER) workshops in UK, Malaysia, Sri Lanka and India. Prof. Jasola has provided consultancy to Commonwealth of Learning (COL) Canada, Commonwealth Educational Media Centre For Asia (CEMCA), UNESCO, Asian Development Bank (ADB) and to several Government agencies in India.';
      case 2:
        return '';
      default:
        return '';
    }
  }
}