import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DocumentScreenProvider extends ChangeNotifier {
  List hello = [];
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

  void deleteFile(String path) async {
    try {
      final file = File(path);

      if (await file.exists()) {
        await file.delete();
        showToast("File deleted");
      } else {
        // print('File not found: $path');
        showToast("Error Deleting File");
      }
    } catch (e) {
      // print('Error deleting file: $e');
    }
  }

  static DocumentScreenProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<DocumentScreenProvider>(
      context,
      listen: listen,
    );
  }
}
