// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pdf_scanner/pages/pdf%20View/pdf_viewer.dart';
import 'package:pdf_scanner/provider/document_screen_provider.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';
import 'package:pdf_scanner/provider/theme_provider.dart';
import 'package:provider/provider.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    // String imageName = widget.imagePath.split('/').last;

    return Scaffold(
        backgroundColor:
            themeProvider.isClick ? Color(0xff121212) : Colors.white,
        appBar: AppBar(
          backgroundColor: themeProvider.isClick
              ? const Color(0xff5A5899)
              : const Color(0xff9694FF),
          title: const Text(
            "Documents",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
            const SizedBox(
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
                                  border: Border.all(
                                      color: themeProvider.isClick
                                          ? Colors.white
                                          : Colors.black)),
                              child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  leading: Container(
                                    // padding: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: themeProvider.isClick
                                              ? const Color(0xff5A5899)
                                              : const Color(0xff9694FF),
                                        )),
                                    height: 90,
                                    width: 50,
                                    child: pdf['preview'],
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
                                  trailing: SizedBox(
                                    width: 67,
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
                                              size: 25,
                                              color: themeProvider.isClick
                                                  ? const Color(0xff5A5899)
                                                  : const Color(0xff9694FF),
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              final filePath = homeProvider
                                                  .pdfPreviews[index]["path"];
                                              final result =
                                                  await Share.shareXFiles(
                                                      [XFile(filePath)]);
                                              if (result.status ==
                                                  ShareResultStatus.dismissed) {
                                                print(
                                                    'Did you not like the pictures?');
                                              }
                                            },
                                            child: Icon(
                                              Icons.share,
                                              size: 25,
                                              color: themeProvider.isClick
                                                  ? const Color(0xff5A5899)
                                                  : const Color(0xff9694FF),
                                            )),
                                        //   I
                                        // conButton(
                                        //       onPressed: () async {
                                        //         final filePath = homeProvider
                                        //             .pdfPreviews[index]["path"];
                                        //         // print(
                                        //         //     "This is file path $filePath");
                                        //         await Share.shareXFiles(filePath);
                                        //       },
                                        //       icon: Icon(
                                        //         Icons.share,
                                        //         size: 23,
                                        //         color: Color(0xff9694FF),
                                        //       ))
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        })
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.54,
                        child: const Column(
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
