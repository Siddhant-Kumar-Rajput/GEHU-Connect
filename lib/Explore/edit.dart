import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_cropper/image_cropper.dart';

class EditPage extends StatefulWidget {
  final List<XFile> images;

  EditPage({required this.images});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late List<XFile> _images;
  late pw.Document _pdfDocument;
  String _pdfFileName = 'document';

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.images);
    _createPdfDocument();
  }

  void _createPdfDocument() {
    final pdf = pw.Document();
    for (var img in _images) {
      final image = pw.MemoryImage(
        File(img.path).readAsBytesSync(),
      );
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(image));
      }));
    }
    _pdfDocument = pdf;
  }

  Future<void> _savePdf(BuildContext context) async {
    final directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No directory selected')),
      );
      return;
    }

    final output = Directory(directoryPath);
    final file = File("${output.path}/$_pdfFileName.pdf");
    await file.writeAsBytes(await _pdfDocument.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF Saved at ${file.path}')),
    );
  }

  Future<void> _sharePdf(BuildContext context) async {
    final bytes = await _pdfDocument.save();
    final tempDir = await getTemporaryDirectory();
    final file = File("${tempDir.path}/$_pdfFileName.pdf");
    await file.writeAsBytes(bytes);

    await Share.shareFiles([file.path], text: 'Here is your PDF document');
  }

  void _renamePdf(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String tempFileName = _pdfFileName;
        return AlertDialog(
          title: Text('Rename PDF'),
          content: TextField(
            onChanged: (value) {
              tempFileName = value;
            },
            decoration: InputDecoration(hintText: "Enter new file name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _pdfFileName = tempFileName;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _cropImage(int index) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _images[index].path,
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
        _images[index] = XFile(croppedFile.path);
        _createPdfDocument(); // Update PDF document with the new cropped image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Images'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _renamePdf(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.file(File(_images[index].path)),
                    ElevatedButton(
                      onPressed: () => _cropImage(index),
                      child: Text('Edit'),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _savePdf(context),
                  icon: Icon(Icons.save),
                  label: Text('Convert to PDF'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _sharePdf(context),
                  icon: Icon(Icons.share),
                  label: Text('Share PDF'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
