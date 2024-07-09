import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionname;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionname,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            Text(sectionname),
            Text(text),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.settings,
              ),
            )
            ],
          ),
        ],
        ),
      );
  }
}