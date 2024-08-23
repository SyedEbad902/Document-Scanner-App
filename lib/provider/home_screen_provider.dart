import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  List<String> files = [];

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

  Future<List<String>> searchFiles() async {
    // Request storage permissions
    if (await Permission.storage.request().isGranted) {
      try {
        // final directory = await getExternalStorageDirectory();
        // final directory = Directory('/storage/emulated/0/Download');
        final directory = Directory(
            '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Documents/');

        // List entities in the directory
        final entities = directory.listSync(recursive: true);
        print('Entities in the directory: $entities');
        for (var entity in entities) {
          if (entity is File) {
            String path = entity.path;
            // print("File found: $path");
            // files.add(path);

            if (path.endsWith('.doc') ||
                path.endsWith('.docx') ||
                path.endsWith('.pdf')) {
              files.add(path);
              print("File found: $path");
            }
          } else {
            print("Skipping non-file entity: ${entity.path}");
          }
        }
        // setState(() {});
        notifyListeners();
      } catch (e) {
        showToast("Error Reading Directory");
        print('Error reading directory: $e');
      }
    } else {
      showToast('Storage permission denied');

      print('Storage permission denied');
    }

    print('Files found: $files');
    return files;
  }

  List<String> pdfFiles = [];
  List<String> docFiles = [];
  filesCheck() async {
    //  String extension = p.extension(files).toLowerCase();
    for (var i = 0; i < files.length; i++) {
      String extension = p.extension(files[i]).toLowerCase();
      if (extension == ".pdf") {
        pdfFiles.add(files[i]);
      } else {
        docFiles.add(files[i]);
      }
    }
    // setState(() {});
    notifyListeners();
  }

  Uint8List? previewImage;

  List<Map<String, dynamic>> pdfPreviews = [];
  
  List<File> pdfFilesPaths = [];

  Future<void> loadFiless() async {
    const directoryPath =
        "/data/user/0/com.example.pdf_scanner/cache/mlkit_docscan_ui_client";
    final directory = Directory(directoryPath);

    if (await directory.exists()) {
      final List<FileSystemEntity> entities = await directory.list().toList();
      pdfFilesPaths = entities
          .whereType<File>()
          .where((file) => file.path.endsWith('.pdf'))
          .toList();
    }
    notifyListeners();
  }

  Future<void> loadFiles() async {
    const directoryPath =
        "/data/user/0/com.example.pdf_scanner/cache/mlkit_docscan_ui_client";
    final directory = Directory(directoryPath);

    if (await directory.exists()) {
      final List<FileSystemEntity> entities = await directory.list().toList();
      List<File> pdfFiles = entities
          .whereType<File>()
          .where((file) => file.path.endsWith('.pdf'))
          .toList();
      // print("this is pdffiless $pdfFiless");

      // Process files in parallel
      await Future.wait(pdfFiles.map((file) async {
        final previewImage = await _renderFirstPage(file.path);
        if (previewImage != null) {
          pdfPreviews.add({
            'path': file.path,
            'preview': previewImage,
          });
        }
      }));

      notifyListeners();
    }
  }

  Future<Widget?> _renderFirstPage(String pdfPath) async {
    try {
      final document = await PdfDocument.openFile(pdfPath);
      final page = await document.getPage(1);

      // Render the first page
      final pageImage = await page.render(
        width: page.width,
        height: page.height,
      );
      await page.close();

      return Image.memory(pageImage!.bytes);
    } catch (e) {
      print('Error rendering PDF page: $e');
      return null;
    }
  }

/////////////////////////////////////////////////////////
  // List<File> _files = [];
  // List<Map<String, dynamic>> pdfPreviews = [];
  // Future<void> loadFiles() async {
  //   // const directoryPath = "/data/user/0/com.example.pdf_scanner/app_flutter";
  //   const directoryPath =
  //       "/data/user/0/com.example.pdf_scanner/cache/mlkit_docscan_ui_client";
  //   final directory = Directory(directoryPath);

  //   if (await directory.exists()) {
  //     final List<FileSystemEntity> entities = await directory.list().toList();
  //     final List<File> files = entities.whereType<File>().toList();

  //     for (File file in files) {
  //       final previewImage = await _renderFirstPage(file.path);
  //       if (previewImage != null) {
  //         // setState(() {
  //         pdfPreviews.add({
  //           'path': file.path,
  //           'preview': previewImage,
  //         });
  //         // });
  //       }
  //     }
  //     notifyListeners();
  //   }
  // }

  // Future<Widget?> _renderFirstPage(String pdfPath) async {
  //   try {
  //     final document = await PdfDocument.openFile(pdfPath);
  //     final page = await document.getPage(1);

  //     final pageImage = await page.render(
  //       width: page.width,
  //       height: page.height,
  //     );
  //     await page.close();

  //     return Image.memory(pageImage!.bytes);
  //   } catch (e) {
  //     print('Error rendering PDF page: $e');
  //     return null;
  //   }
  // }

  static HomeProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<HomeProvider>(
      context,
      listen: listen,
    );
  }
}
