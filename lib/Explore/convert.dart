import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

class ConvertScreen extends StatefulWidget {
  final File file;
  final String conversionType;

  ConvertScreen({required this.file, required this.conversionType});

  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  bool isConverting = false;
  String convertedFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Convert File")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.conversionType == 'pdf_to_word' ? Icons.picture_as_pdf : Icons.description,
              size: 100,
            ),
            Text('File: ${widget.file.path.split('/').last}'),
            if (convertedFilePath.isEmpty)
              ElevatedButton(
                onPressed: isConverting ? null : convertFile,
                child: isConverting ? CircularProgressIndicator() : Text("Convert"),
              ),
            if (convertedFilePath.isNotEmpty)
              ElevatedButton(
                onPressed: downloadFile,
                child: Text("Download"),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> convertFile() async {
    setState(() {
      isConverting = true;
    });

    const apiKey = 'hVWGpy2mhLogrqbG';
    final apiUrl = widget.conversionType == 'pdf_to_word'
        ? 'https://v2.convertapi.com/convert/pdf/to/docx?Secret=hVWGpy2mhLogrqbG'
        : 'https://v2.convertapi.com/convert/docx/to/pdf?Secret=hVWGpy2mhLogrqbG';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('file', widget.file.path));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print("Response Headers: ${response.headers}");
        print("Response Body: $responseData");

        var jsonResponse = jsonDecode(responseData);

        if (jsonResponse['Files'] != null && jsonResponse['Files'].isNotEmpty) {
          var convertedFile = jsonResponse['Files'][0];
          var fileName = convertedFile['FileName'];
          var fileExt = convertedFile['FileExt'];
          var fileData = base64.decode(convertedFile['FileData']);

          var dir = await getApplicationDocumentsDirectory();
          String newPath = '${dir.path}/$fileName';
          File file = File(newPath);
          await file.writeAsBytes(fileData);

          setState(() {
            convertedFilePath = newPath;
            isConverting = false;
          });
        } else {
          setState(() {
            isConverting = false;
          });
          print("Conversion failed: Invalid response format");
        }
      } else {
        var responseData = await response.stream.bytesToString();
        setState(() {
          isConverting = false;
        });
        print("Conversion failed: ${response.statusCode}, Response: $responseData");
      }
    } catch (e) {
      setState(() {
        isConverting = false;
      });
      print("Error during file conversion: $e");
    }
  }

  Future<void> downloadFile() async {
    if (convertedFilePath.isNotEmpty) {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: convertedFilePath.split('/').last,
      );

      if (result != null) {
        final file = File(result);
        await file.writeAsBytes(await File(convertedFilePath).readAsBytes());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File saved to $result')),
        );
      }
    }
  }
}
