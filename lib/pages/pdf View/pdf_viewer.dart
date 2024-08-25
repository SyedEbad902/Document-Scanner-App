import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

class PdfViewer extends StatefulWidget {
  final filepath;
  const PdfViewer({super.key, required this.filepath});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfControllerPinch pdffControllerPinch;
  int totalPageCount = 0;
  @override
  void initState() {
    super.initState();
    pdffControllerPinch =
        PdfControllerPinch(document: PdfDocument.openFile(widget.filepath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        title: const Text(
          "PDF Viewer",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Share.shareXFiles([XFile(widget.filepath)]);
              },
              icon: const Icon(
                Icons.share,
                size: 25,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: buildUi(),
    );
  }

  Widget buildUi() {
    return Column(
      children: [
        Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Pages $totalPageCount",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.red,
          height: 15,
        ),
        pdfView(),
      ],
    );
  }

  Widget pdfView() {
    return Expanded(
        child: PdfViewPinch(
      controller: pdffControllerPinch,
      backgroundDecoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Color(0x73000000), blurRadius: 4, offset: Offset(2, 2))
      ], color: Colors.white24),
      onDocumentLoaded: (doc) {
        setState(() {
          totalPageCount = doc.pagesCount;
        });
      },
    ));
  }
}
