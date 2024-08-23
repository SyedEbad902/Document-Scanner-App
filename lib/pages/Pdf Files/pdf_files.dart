import 'package:flutter/material.dart';
import 'package:pdf_scanner/pages/pdf%20View/pdf_viewer.dart';

import '../../provider/home_screen_provider.dart';

class PdfFiles extends StatefulWidget {
  const PdfFiles({super.key, });

  @override
  State<PdfFiles> createState() => _PdfFilesState();
}

class _PdfFilesState extends State<PdfFiles> {
  // void _openFile(String path) {
  //   OpenFile.open(path);
  // }

  @override
  Widget build(BuildContext context) {
    final homeProvider = HomeProvider.of(context);

    return homeProvider.pdfFiles.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                'Pdf Files',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: Colors.red,
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: homeProvider.pdfFiles.length,
                itemBuilder: (context, index) {
                  final path = homeProvider.pdfFiles[index];
                  // String extension =
                  //     p.extension(widget.getFiles[index]).toLowerCase();

                  // print(path.endsWith('.docx'));
                  return GestureDetector(
                    onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>PdfViewer(filepath: path) )),
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
                        leading: Image.asset(
                                                  "assets/images/pdf1.png",
                                                  fit: BoxFit.contain,
                                                  height: 50,
                                                  width: 50,
                                                  // color: Colors.transparent,
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
