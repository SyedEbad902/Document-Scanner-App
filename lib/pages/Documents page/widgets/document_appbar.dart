import 'dart:io';

import 'package:flutter/material.dart';

class DocumentAppBar extends StatelessWidget {
  const DocumentAppBar({
    super.key,
  });
  Future<int> countFilesInDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);

    // Check if the directory exists
    if (await directory.exists()) {
      // List all the files in the directory
      final List<FileSystemEntity> entities = await directory.list().toList();

      // Filter the list to include only files (exclude directories)
      final List<FileSystemEntity> files =
          entities.where((entity) => entity is File).toList();

      // Return the count of files
      return files.length;
    } else {
      // If the directory does not exist, return 0
      return 0;
    }
  }

  void checkFilesCount() async {
    final directoryPath = '/data/user/0/com.example.pdf_scanner/app_flutter';
    int fileCount = await countFilesInDirectory(directoryPath);

    print('Number of files in the directory: $fileCount');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 28,
            ),
          ),
          GestureDetector(
            onTap: () {
              checkFilesCount();
            },
            child: const Icon(
              Icons.settings,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
