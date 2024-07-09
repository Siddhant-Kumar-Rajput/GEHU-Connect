import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_app/Explore/edit.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
      });
    }
  }

  void _proceed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(images: _selectedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Images from Gallery'),
      ),
      body: Center(
        child: _selectedImages.isEmpty
            ? ElevatedButton(
                onPressed: _pickImages,
                child: Text('Select Images'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Image.file(File(_selectedImages[index].path));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedImages.clear();
                          });
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _proceed,
                        child: Text('Proceed'),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

// // class EditPage extends StatelessWidget {
// //   final List<XFile> images;

// //   EditPage({required this.images});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Edit Images'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: images.length,
// //         itemBuilder: (context, index) {
// //           return Image.file(File(images[index].path));
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'image_edit_page.dart'; // Import the new image edit page

// class GalleryPage extends StatefulWidget {
//   @override
//   _GalleryPageState createState() => _GalleryPageState();
// }

// class _GalleryPageState extends State<GalleryPage> {
//   final ImagePicker _picker = ImagePicker();
//   List<XFile> _selectedImages = [];

//   Future<void> _pickImages() async {
//     final List<XFile>? images = await _picker.pickMultiImage();
//     if (images != null && images.isNotEmpty) {
//       setState(() {
//         _selectedImages = images;
//       });
//     }
//   }

//   void _proceed() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ImageEditPage(images: _selectedImages),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Images from Gallery'),
//       ),
//       body: Center(
//         child: _selectedImages.isEmpty
//             ? ElevatedButton(
//                 onPressed: _pickImages,
//                 child: Text('Select Images'),
//               )
//             : Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: _selectedImages.length,
//                       itemBuilder: (context, index) {
//                         return Image.file(File(_selectedImages[index].path));
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _selectedImages.clear();
//                           });
//                         },
//                         child: Text('Cancel'),
//                       ),
//                       ElevatedButton(
//                         onPressed: _proceed,
//                         child: Text('Proceed'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }