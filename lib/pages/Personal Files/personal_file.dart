import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as p;
import 'package:pdf_scanner/provider/home_screen_provider.dart';

import '../pdf View/pdf_viewer.dart';
import 'widgets/search_bar.dart';

class GetFiles extends StatefulWidget {
  // final List getFiles;

  const GetFiles({
    super.key,
  });

  @override
  State<GetFiles> createState() => _GetFilesState();
}

class _GetFilesState extends State<GetFiles> {
  // void _openFile(String path) {
  //   OpenFile.open(path);
  // }

  @override
  Widget build(BuildContext context) {
    final homeProvider = HomeProvider.of(context);
    return homeProvider.files.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Personal Files',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xff9694FF),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSearchBar(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Your Files",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeProvider.files.length,
                      itemBuilder: (context, index) {
                        final path = homeProvider.files[index];
                        String extension = p
                            .extension(homeProvider.files[index])
                            .toLowerCase();

                        // print(path.endsWith('.docx'));
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PdfViewer(
                                        filepath: path,
                                      ))),
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

                                child: extension == ".pdf"
                                    ? Image.asset(
                                        "assets/images/pdf1.png",
                                        fit: BoxFit.contain,
                                        height: 50,
                                        width: 50,
                                        // color: Colors.transparent,
                                      )
                                    : Image.asset(
                                        "assets/images/docx.png",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
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
                  ],
                ),
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