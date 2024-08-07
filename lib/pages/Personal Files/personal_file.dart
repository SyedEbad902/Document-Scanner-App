import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class FileListPage extends StatefulWidget {
  @override
  _FileListPageState createState() => _FileListPageState();
}

class _FileListPageState extends State<FileListPage> {
  // List<String> _filePaths = [];

  @override
  void initState() {
    super.initState();
    // _requestPermission();
    _searchFiles();
  }

  // Future<void> _requestPermission() async {
  //   if (await Permission.storage.request().isGranted) {
  //     _listDocumentFiles();
  //   } else {
  //     // Handle the case when the permission is not granted
  //     print('Storage permission not granted.');
  //   }
  // }

  // Future<void> _listDocumentFiles() async {
  //   List<String> filePaths = [];
  //   try {
  //     // Get external storage directory
  //     final directory = await getExternalStorageDirectory();
  //     if (directory != null) {
  //       filePaths = await _searchFiles(directory);
  //       print("success");
  //     }
  //   } catch (e) {
  //     print('Failed to list files: $e');
  //   }

  //   setState(() {
  //     _filePaths = filePaths;
  //   });
  // }
  bool iscontainFile = false;
  List<String> files = [];
  Future<List<String>> _searchFiles() async {
    // Request storage permissions
    if (await Permission.storage.request().isGranted) {
      try {
        // final directory = await getExternalStorageDirectory();
        final directory = Directory('/storage/emulated/0/Download');
        print(directory);
        if (directory == null) {
          print('External storage directory not available');
          return files;
        }

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
              setState(() {
                iscontainFile = true;
              });
              print("File found: $path");
            }
          } else {
            print("Skipping non-file entity: ${entity.path}");
          }
        }
      } catch (e) {
        print('Error reading directory: $e');
      }
    } else {
      print('Storage permission denied');
    }

    print('Files found: $files');
    return files;
  }

  // Future<List<String>> _searchFiles(Directory directory) async {
  //   List<String> files = [];
  //   try {
  //     final entities = directory.listSync(recursive: true);
  //     print();
  //     for (var entity in entities) {
  //       if (entity is File) {
  //         String path = entity.path;
  //         if (path.endsWith('.doc') ||
  //             path.endsWith('.docx') ||
  //             path.endsWith('.pdf')) {

  //           files.add(path);
  //           print("this is $path");
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print('Error reading directory: $e');
  //   }
  //   return files;
  //   // print(files);
  // }

  void _openFile(String path) {
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return iscontainFile
        ? Scaffold(
            appBar: AppBar(
              title: Text('Document Files'),
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    List<String> files = await _searchFiles();
                    print('Files found: $files');
                  },
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final path = files[index];
                return ListTile(
                  title: Text(path.split('/').last),
                  onTap: () => _openFile(path),
                );
              },
            ),
          )
        : Scaffold(
         appBar: AppBar(
        title: Text('Document Files'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              List<String> files = await _searchFiles();
              print('Files found: $files');
            },
          ),
        ],
      ),
      body: Center(child: CircularProgressIndicator(),),
        );
  }
}
























// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';

// class PersonalFiles extends StatefulWidget {
//   const PersonalFiles({super.key});

//   @override
//   State<PersonalFiles> createState() => _PersonalFilesState();
// }

// class _PersonalFilesState extends State<PersonalFiles> {
  
  
//   List<String?> _filePaths = [];

//    Future<void> _pickFiles() async {
//     try {
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['doc', 'docx', 'pdf'],
//         allowMultiple: true,
//       );

//       if (result != null) {
//         setState(() {
//           _filePaths = result.paths.where((path) => path != null).toList();
//         });
//       }
//     } catch (e) {
//       print('Failed to pick files: $e');
//     }
//   }

//   void _openFile(String path) {
//     OpenFile.open(path);
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Document Files'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _pickFiles,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: _filePaths.length,
//         itemBuilder: (context, index) {
//           final path = _filePaths[index];
//           return ListTile(
//             title: Text(path!.split('/').last),
//             onTap: () => _openFile(path),
//           );
//         },
//       ),
//     );
//   }
// }