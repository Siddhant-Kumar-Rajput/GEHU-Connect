import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _capturedImages = [];

  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final croppedImage = await ImageCropper()
          .cropImage(sourcePath: image.path, aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ], uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ]);

      if (croppedImage != null) {
        setState(() {
          _capturedImages.add(XFile(croppedImage.path));
        });
      }
    }
  }

  void _retakeImage() {
    setState(() {
      _capturedImages.clear();
    });
    _captureImage();
  }

  void _continueCapture() {
    _captureImage();
  }

  void _proceed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(images: _capturedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capture Image'),
      ),
      body: Center(
        child: _capturedImages.isEmpty
            ? ElevatedButton(
                onPressed: _captureImage,
                child: Text('Capture Image'),
              )
            : Column(
                children: [
                  Image.file(File(_capturedImages.last.path)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _retakeImage,
                        child: Text('Retake'),
                      ),
                      ElevatedButton(
                        onPressed: _continueCapture,
                        child: Text('Continue Capture'),
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

class EditPage extends StatelessWidget {
  final List<XFile> images;

  EditPage({required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Images'),
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.file(File(images[index].path));
        },
),
);
}
}