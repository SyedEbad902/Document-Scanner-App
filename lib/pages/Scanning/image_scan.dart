// import 'dart:io';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_scanner/navbar/my_nav_bar.dart';

// import '../Documents page/documents_screen.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final _controller = DocumentScannerController();

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _imagePath;
  randomNum() {
    var random = Random();
    var diceface = random.nextInt(1000000000);
    return diceface;
  }

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
            final pdfPath = '${directory.path}/New_file_${randomNum()}.pdf';

            // Create a PDF document
            final pdf = pw.Document();

            // Add the image to the PDF document
            final image = pw.MemoryImage(imageBytes);
            pdf.addPage(
              pw.Page(
                build: (pw.Context context) {
                  return pw.Center(
                    child: pw.Image(image),
                  );
                },
              ),
            );

            // Save the PDF file
            final pdfFile = File(pdfPath);
            await pdfFile.writeAsBytes(await pdf.save());

            setState(() {
              _imagePath = pdfPath;
            });

            if (_imagePath != null) {
              showToast("Document Saved");
              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const MyNavBar()),
              );
              // ignore: avoid_print
              print("PDF saved at: $_imagePath");
            }

            // final File? photoTaken = _controller.pictureTaken;
            // ignore: avoid_print

            // final Uint8List? photoCropped = _controller.pictureCropped;
          }

// String randomNum() {
//   return DateTime.now().millisecondsSinceEpoch.toString();
// }

          // onSave: (Uint8List imageBytes) async {
          //   final directory = await getApplicationDocumentsDirectory();
          //   final imagePath =
          //       '${directory.path}/filtered_image${randomNum()}.pdf';
          //   File imageFile = File(imagePath);
          //   print(imageFile);
          //   await imageFile.writeAsBytes(imageBytes);
          //   setState(() {
          //     _imagePath = imagePath;
          //   });
          //   if (_imagePath != null) {
          //     showToast("Document Saved");
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
          //     print("saved");
          //   }
          //   final File? photoTaken = _controller.pictureTaken;
          //   print(" taken photo${photoTaken}");

          //   final Uint8List? photoCropped = _controller.pictureCropped;
          //   print(" croped photo${photoCropped}");
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
