// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pdf_scanner/pages/pdf%20View/pdf_viewer.dart';
import 'package:pdf_scanner/provider/document_screen_provider.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';
import 'package:share_plus/share_plus.dart';


class DocumentScreen extends StatefulWidget {
  // final String? imagePath;

  const DocumentScreen({
    super.key,
  });

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  // List<String> items = ['Sort by date', 'Sort by week', 'Sort by month'];
  // String? selectedValue;

  // ignore: unused_field
  // Uint8List? _previewImage;
  // final List<Map<String, dynamic>> _pdfPreviews = [];

  @override
  Widget build(BuildContext context) {
    final homeProvider = HomeProvider.of(context);
    final documentProvider = DocumentScreenProvider.of(context);
    // String imageName = widget.imagePath.split('/').last;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff9694FF),
          title: Text(
            "Documents",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const DocumentAppBar(),

                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Your Documents",
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text(
                                    "11 Pages",
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff9694FF)),
                                  ),
                                  trailing: Container(
                                    width: 71,
                                    // color: Colors.blue,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                documentProvider.deleteFile(
                                                    homeProvider
                                                            .pdfPreviews[index]
                                                        ["path"]);

                                                homeProvider.pdfPreviews
                                                    .removeAt(index);
                                                // provider.pdfFiless.removeAt(index);
                                                homeProvider.loadFiless();
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: 23,
                                              color: Color(0xff9694FF),
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.share,
                                              size: 23,
                                              color: Color(0xff9694FF),
                                            ))
                                      ],
                                    ),
                                  )),
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
        ));
  }
}
