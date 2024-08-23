// ignore_for_file: avoid_print


import 'package:flutter/material.dart';
import 'package:pdf_scanner/pages/Documents%20page/widgets/search_bar.dart';
import 'package:pdf_scanner/pages/pdf%20View/pdf_viewer.dart';
import 'package:pdf_scanner/provider/document_screen_provider.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';

import 'widgets/document_appbar.dart';

class DocumentScreen extends StatefulWidget {
  // final String? imagePath;

  const DocumentScreen({
    super.key,
  });

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  List<String> items = ['Sort by date', 'Sort by week', 'Sort by month'];
  String? selectedValue;

  // ignore: unused_field
  // Uint8List? _previewImage;
  // final List<Map<String, dynamic>> _pdfPreviews = [];

  

  @override
  void initState() {
    super.initState();
    // _loadFiles();
    // List<File> file = _files.map((path) => File(path)).toList();
    // Call the function to load files in initState
  }

//////////////////////////////////////////////////////////////
  // Future<void> _loadFiles() async {
  //   // const directoryPath = "/data/user/0/com.example.pdf_scanner/app_flutter";
  //   const directoryPath =
  //       "/data/user/0/com.example.pdf_scanner/cache/mlkit_docscan_ui_client";
  //   final directory = Directory(directoryPath);

  //   if (await directory.exists()) {
  //     final List<FileSystemEntity> entities = await directory.list().toList();
  //     print("this is entity $entities");
  //     final List<File> files = entities.whereType<File>().toList();
  //     print(files);

  //     for (File file in files) {
  //       final previewImage = await _renderFirstPage(file.path);
  //       if (previewImage != null) {
  //         setState(() {
  //           _pdfPreviews.add({
  //             'path': file.path,
  //             'preview': previewImage,
  //             // 'count': ,
  //           });
  //         });
  //       }
  //     }
  //     // setState(() {});
  //     // print(_pdfPreviews);
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

  @override
  Widget build(BuildContext context) {
    final homeProvider = HomeProvider.of(context);
    final documentProvider = DocumentScreenProvider.of(context);
    // String imageName = widget.imagePath.split('/').last;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DocumentAppBar(),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Documents",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const CustomSearchBar(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    value: selectedValue,
                    hint: const Text('Sort..'),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Today",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                homeProvider.pdfPreviews.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeProvider.pdfPreviews.length,
                        itemBuilder: (context, index) {
                          final pdf = homeProvider.pdfPreviews[index];
                          print("this is pdf $pdf");

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PdfViewer(filepath: pdf["path"])));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.only(top: 5),
                              height: 90,
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
                                      border: Border.all(
                                          color: const Color(0xff9694FF))),
                                  height: 90,
                                  width: 50,
                                  child: pdf['preview'] != null
                                      ? pdf['preview']
                                      : null,
                                  //  Image.file(file),
                                  // child: Text(
                                  //   ".pdf",
                                  //   style: TextStyle(color: Color(0xff9694FF)),
                                  // ),
                                ),
                                title: Text(
                                  // imageName
                                  pdf['path'].split('/').last,
                                  //  ??
                                  // file.path.split('/').last,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: const Text(
                                  "11 Pages",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff9694FF)),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      // print(
                                      //     " Deleted file ${provider.pdfPreviews[index]["path"]}");
                                      //     print( "this is pdfpreviews ${provider.pdfPreviews.removeAt(index)}");
                                      //     print( "this is pdffiless${provider.pdfFiless.removeAt(index)}");

                                      setState(() {
                                        documentProvider.deleteFile(homeProvider
                                            .pdfPreviews[index]["path"]);

                                        homeProvider.pdfPreviews
                                            .removeAt(index);
                                        // provider.pdfFiless.removeAt(index);
                                        homeProvider.loadFiless();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Color(0xff9694FF),
                                    )),
                              ),
                            ),
                          );
                        })
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        )
        // : AlertDialog(
        //     content: const Row(
        //       children: [
        //         CircularProgressIndicator(color: Color(0xff9694FF)),
        //         SizedBox(
        //           width: 20,
        //         ),
        //         Text(
        //           "Opening Documents...",
        //           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        //         )
        //       ],
        //     ),
        //     backgroundColor: Colors.white,
        //     shadowColor: Colors.grey,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         side: const BorderSide(color: Color(0xff9694FF)))),
        );
  }
}
