import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;

class GetFiles extends StatefulWidget {
  final List getFiles;

  const GetFiles({super.key, required this.getFiles});

  @override
  State<GetFiles> createState() => _GetFilesState();
}

class _GetFilesState extends State<GetFiles> {
  void _openFile(String path) {
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return widget.getFiles.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Document Files'),
              backgroundColor: const Color(0xff9694FF),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.getFiles.length,
                itemBuilder: (context, index) {
                  final path = widget.getFiles[index];
                  String extension =
                      p.extension(widget.getFiles[index]).toLowerCase();

                  // print(path.endsWith('.docx'));
                  return GestureDetector(
                    onTap: () => _openFile(path),
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.only(top: 8),
                      height: 73,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all()),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        leading: Container(
                          // padding: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0xff9694FF))),
                          height: 40,
                          width: 45,
                          child: Center(
                            child: Text(
                              extension == ".pdf" ? ".pdf" : ".docx",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9694FF),
                                  fontSize: 13),
                            ),
                          ),
                        ),
                        title: Text(
                          path.split('/').last,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Document Files'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
    
  }
}









// class FileListPage extends StatefulWidget {
//   final List getFiles;
//     const FileListPage({super.key, required this.getFiles});

  
//   @override
//   FileListPageState createState() => FileListPageState();

// }


// class FileListPageState extends State<FileListPage> {
//   // List<String> _filePaths = [];

//   @override
//   void initState() {
//     super.initState();
//     // _requestPermission();
//     // _searchFiles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  
//         ? Scaffold(
//             appBar: AppBar(
//               title: Text('Document Files'),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: () async {
//                     List<String> files = await _searchFiles();
//                     print('Files found: $files');
//                   },
//                 ),
//               ],
//             ),
//             body: ListView.builder(
//               itemCount: files.length,
//               itemBuilder: (context, index) {
//                 final path = files[index];
//                 return ListTile(
//                   title: Text(path.split('/').last),
//                   onTap: () => _openFile(path),
//                 );
//               },
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               title: Text('Document Files'),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.refresh),
//                   onPressed: () async {
//                     List<String> files = await _searchFiles();
//                     print('Files found: $files');
//                   },
//                 ),
//               ],
//             ),
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//   }
// }















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