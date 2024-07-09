// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:googlemapsapp/edit.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

// class ImageEditPage extends StatefulWidget {
//   final List<XFile> images;

//   ImageEditPage({required this.images});

//   @override
//   _ImageEditPageState createState() => _ImageEditPageState();
// }

// class _ImageEditPageState extends State<ImageEditPage> {
//   List<XFile> _editedImages = [];

//   @override
//   void initState() {
//     super.initState();
//     _editedImages = widget.images;
//   }

//   Future<void> _cropImage(XFile image) async {
//     File? croppedFile = (await ImageCropper()
//         .cropImage(sourcePath: image.path, aspectRatioPresets: [
//       CropAspectRatioPreset.square,
//       CropAspectRatioPreset.ratio3x2,
//       CropAspectRatioPreset.original,
//       CropAspectRatioPreset.ratio4x3,
//       CropAspectRatioPreset.ratio16x9
//     ], uiSettings: [
//       AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: Colors.deepOrange,
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false),
//     ])) as File?;

//     if (croppedFile != null) {
//       setState(() {
//         int index = _editedImages.indexOf(image);
//         _editedImages[index] = XFile(croppedFile.path);
//       });
//     }
//   }

//   void _proceed() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditPage(images: _editedImages),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Images'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _editedImages.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Image.file(File(_editedImages[index].path)),
//                     ElevatedButton(
//                       onPressed: () => _cropImage(_editedImages[index]),
//                       child: Text('Crop Image'),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: _proceed,
//               child: Text('Proceed to PDF'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:my_app/Explore/camera.dart';

class ImageEditPage extends StatefulWidget {
  final List<XFile> images;

  ImageEditPage({required this.images});

  @override
  _ImageEditPageState createState() => _ImageEditPageState();
}

class _ImageEditPageState extends State<ImageEditPage> {
  List<XFile> _editedImages = [];

  @override
  void initState() {
    super.initState();
    _editedImages = List.from(widget.images); // Ensure a new list is created
  }

  Future<void> _cropImage(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        int index = _editedImages.indexOf(image);
        _editedImages[index] = XFile(croppedFile.path);
      });
    }
  }

  void _proceed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(images: _editedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Images'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _editedImages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.file(File(_editedImages[index].path)),
                    ElevatedButton(
                      onPressed: () => _cropImage(_editedImages[index]),
                      child: Text('Crop Image'),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _proceed,
              child: Text('Proceed to PDF'),
            ),
          ),
        ],
     ),
);
}
}