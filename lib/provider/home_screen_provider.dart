import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
