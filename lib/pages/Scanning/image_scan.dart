import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DocumentScanner extends StatefulWidget {
  @override
  _DocumentScannerState createState() => _DocumentScannerState();
}

class _DocumentScannerState extends State<DocumentScanner> {
  File? _image;
  img.Image? _filteredImg;
  final picker = ImagePicker();

  Future<void> _captureImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _filteredImg = img.decodeImage(_image!.readAsBytesSync());
        });
      } else {
        // Handle the case when the user cancels the camera action
        print('No image selected.');
      }
    } catch (e) {
      print('Error while capturing image: $e');
    }
  }

  Future<void> _applyFilter(String filter) async {
    if (_filteredImg == null) return;

    img.Image filteredImage;

    switch (filter) {
      case 'grayscale':
        filteredImage = img.grayscale(_filteredImg!);
        break;
      case 'sepia':
        filteredImage = img.sepia(_filteredImg!);
        break;
      case 'invert':
        filteredImage = img.invert(_filteredImg!);
        break;
      case 'brightness':
        // filteredImage = applyMagicColorEffect(_filteredImg!);
        filteredImage = img.adjustColor(_filteredImg!, brightness: 10);
        break;
      case 'contrast':
        filteredImage = img.adjustColor(_filteredImg!, contrast: 1.5);
        break;
      default:
        filteredImage = _filteredImg!;
        break;
    }

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = path.join(directory.path, 'filtered_image.png');
    final outputImage = File(imagePath)
      ..writeAsBytesSync(img.encodePng(filteredImage));
    print(outputImage.path);

    setState(() {
      _image = outputImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _captureImage();
        },
        child: Icon(Icons.camera),
      ),
      appBar: AppBar(
        title: Text('Document Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? Text('No image selected.')
                  : Container(
                      height: 480,
                      width: double.infinity,
                      child: Image.file(
                        _image!,
                        fit: BoxFit.fill,
                      )),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _applyFilter('grayscale');
                  print("button pressed");
                },
                child: Text('Apply Filter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
