import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  final List _bannerimg=[];

  getBanner(){
    return _firestore.collection('bannergehu').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) { 
        setState(() {
          _bannerimg.add(doc['image']);
        });
      });
    });
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.yellow,
        ),

        child: PageView.builder(
          itemCount: _bannerimg.length,
          itemBuilder: (context, index){
          return Image.network(_bannerimg[index]);
        })

      ),
    );
  }
}