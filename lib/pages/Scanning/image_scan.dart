// import 'dart:io';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:path_provider/path_provider.dart';

// import '../Documents page/documents_screen.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final _controller = DocumentScannerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DocumentScanner(
        controller: _controller,
        generalStyles: const GeneralStyles(
          hideDefaultBottomNavigation: true,
          messageTakingPicture: 'Taking picture of document',
          messageCroppingPicture: 'Cropping picture of document',
          messageEditingPicture: 'Editing picture of document',
          messageSavingPicture: 'Saving picture of document',
          baseColor: Colors.teal,
        ),
        takePhotoDocumentStyle: TakePhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top + 25,
          hideDefaultButtonTakePicture: true,
          onLoading: const CircularProgressIndicator(
            color: Colors.white,
          ),
          children: [
            // * AppBar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.teal,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  bottom: 15,
                ),
                child: const Center(
                  child: Text(
                    'Take a picture of the document',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            // * Button to take picture
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: _controller.takePhoto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text(
                    'Take picture',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        cropPhotoDocumentStyle: CropPhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
          maskColor: Colors.teal.withOpacity(0.2),
        ),
        editPhotoDocumentStyle: EditPhotoDocumentStyle(
          top: MediaQuery.of(context).padding.top,
        ),
        resolutionCamera: ResolutionPreset.ultraHigh,
        pageTransitionBuilder: (child, animation) {
          final tween = Tween<double>(begin: 0, end: 1);

          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return ScaleTransition(
            scale: tween.animate(curvedAnimation),
            child: child,
          );
        },
        onSave: (Uint8List imageBytes) async {
          final directory = await getApplicationDocumentsDirectory();
          final imagePath = '${directory.path}/filtered_image2.png';
          File imageFile = File(imagePath);
          print(imageFile);
          await imageFile.writeAsBytes(imageBytes);
          setState(() {
            _imagePath = imagePath;
          });
          if (_imagePath != null) {
            print("saved");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DocumentScreen(imagePath: imagePath),
            //   ),
            // );
          }
          final File? photoTaken = _controller.pictureTaken;
          print(" taken photo${photoTaken}");

          final Uint8List? photoCropped = _controller.pictureCropped;
          print(" croped photo${photoCropped}");
        },

        // onSave: (Uint8List imageBytes) async {
        //   final directoryPath =
        //       '/data/user/0/com.example.pdf_scanner/app_flutter/User_images';
        //   final filePath =
        //       '$directoryPath/filtered_image.png'; // Specify the file name

        //   // Ensure the directory exists
        //   final directory = Directory(directoryPath);
        //   if (!await directory.exists()) {
        //     await directory.create(recursive: true);
        //   }

        //   // Check if the file already exists and is not a directory
        //   final file = File(filePath);
        //   if (await file.exists()) {
        //     if (await FileSystemEntity.isDirectory(filePath)) {
        //       // If it's a directory, delete it
        //       await Directory(filePath).delete(recursive: true);
        //     }
        //   }

        //   // Now save the image to the file
        //   await file.writeAsBytes(imageBytes);

        //   print('Directory path: $directoryPath');
        //   print('File path: $filePath');
        //   print('Is Directory: ${await Directory(filePath).exists()}');
        //   print('Is File: ${await file.exists()}');
        //   dispose();

        //   // Save the image bytes to the file
        //   // File imageFile = File(filePath);
        //   // await imageFile.writeAsBytes(imageBytes);
        //   // print("this is image path${filePath}");
        //   // final File? photoTaken = _controller.pictureTaken;
        //   // print(photoTaken);

        //   // final Uint8List? photoCropped = _controller.pictureCropped;
        //   // print("////////////////////////////////////////////////////");
        //   // print(photoCropped);
        //   // print("end");

        //   // return imagePath; // Return the path where the image was saved
        // },
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf_scanner/pages/Documents%20page/documents_screen.dart';

// class DocumentScanner extends StatefulWidget {
//   @override
//   _DocumentScannerState createState() => _DocumentScannerState();
// }

// class _DocumentScannerState extends State<DocumentScanner> {
//   File? _image;
//   img.Image? _filteredImg;
//   final picker = ImagePicker();

//   Future<void> _captureImage() async {
//     try {
//       final pickedFile = await picker.pickImage(source: ImageSource.camera);

//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//           _filteredImg = img.decodeImage(_image!.readAsBytesSync());
//         });
//       } else {
//         // Handle the case when the user cancels the camera action
//         print('No image selected.');
//       }
//     } catch (e) {
//       print('Error while capturing image: $e');
//     }
//   }

//   String? outputpath;
//   Future<void> _applyFilter(String filter) async {
//     if (_filteredImg == null) return;

//     img.Image filteredImage;

//     switch (filter) {
//       case 'grayscale':
//         filteredImage = img.grayscale(_filteredImg!);
//         break;
//       case 'sepia':
//         filteredImage = img.sepia(_filteredImg!);
//         break;
//       case 'invert':
//         filteredImage = img.invert(_filteredImg!);
//         break;
//       case 'brightness':
//         // filteredImage = applyMagicColorEffect(_filteredImg!);
//         filteredImage = img.adjustColor(_filteredImg!, brightness: 10);
//         break;
//       case 'contrast':
//         filteredImage = img.adjustColor(_filteredImg!, contrast: 1.5);
//         break;
//       default:
//         filteredImage = _filteredImg!;
//         break;
//     }

//     final directory = await getApplicationDocumentsDirectory();
//     final imagePath = path.join(directory.path, 'filtered_image.png');
//     final outputImage = File(imagePath)
//       ..writeAsBytesSync(img.encodePng(filteredImage));
//     outputpath = outputImage.path;

//     print("this is path ${outputImage.path}");

//     setState(() {
//       _image = outputImage;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _captureImage();
//         },
//         child: Icon(Icons.camera),
//       ),
//       appBar: AppBar(
//         title: Text('Document Scanner'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: ((context) =>  DocumentScreen(
//                             imagePath: outputpath! ))));
//               },
//               icon: Icon(Icons.save)),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               _image == null
//                   ? Text('No image selected.')
//                   : Container(
//                       height: 480,
//                       width: double.infinity,
//                       child: Image.file(
//                         _image!,
//                         fit: BoxFit.fill,
//                       )),
//               SizedBox(height: 5),
//               ElevatedButton(
//                 onPressed: () {
//                   _applyFilter('grayscale');
//                   print("button pressed");
//                 },
//                 child: Text('Apply Filter'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
