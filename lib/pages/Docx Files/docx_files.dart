import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class DocxFiles extends StatefulWidget {
  final List docFiles;

  const DocxFiles({super.key, required this.docFiles});

  @override
  State<DocxFiles> createState() => _DocxFilesState();
}

class _DocxFilesState extends State<DocxFiles> {
  void _openFile(String path) {
    OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    return widget.docFiles.isNotEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text(
                'Word Files',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              backgroundColor: const Color(0xff0771b4),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.docFiles.length,
                itemBuilder: (context, index) {
                  final path = widget.docFiles[index];
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

                          child: Image.asset(
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
