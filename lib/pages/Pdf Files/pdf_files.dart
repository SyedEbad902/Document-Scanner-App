import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class PdfFiles extends StatefulWidget {
  final List pdfFiles;
  const PdfFiles({super.key, required this.pdfFiles});

  @override
  State<PdfFiles> createState() => _PdfFilesState();
}

class _PdfFilesState extends State<PdfFiles> {
   void _openFile(String path) {
    OpenFile.open(path);
  }
  @override
  Widget build(BuildContext context) {
    return  widget.pdfFiles.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Pdf Files'),
              backgroundColor: const Color(0xff9694FF),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.pdfFiles.length,
                itemBuilder: (context, index) {
                  final path = widget.pdfFiles[index];
                  // String extension =
                  //     p.extension(widget.getFiles[index]).toLowerCase();

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
                            child: const Text(
                              ".pdf" ,
                              style: TextStyle(
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



