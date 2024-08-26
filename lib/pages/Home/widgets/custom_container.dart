import 'package:flutter/material.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';
import 'package:pdf_scanner/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

class CustomContainers extends StatelessWidget {
  final List getfiles;
  final List getpdfFile;
  final List pdfFiles;
  final List docFiles;
  // final   Uint8List? previewImage;

  const CustomContainers({
    super.key,
    required this.getfiles,
    required this.getpdfFile,
    required this.pdfFiles,
    required this.docFiles,
  });

  @override
  Widget build(BuildContext context) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    final homeProvider = HomeProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  homeProvider.filteredFiles = homeProvider.files;
                  navigationProvider.navigateTo(context, '/personalFiles');
                },
                child: Container(
                  height: 74,
                  width: 142,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 167, 167, 170)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff9694FF),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 20,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "Personal",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${getfiles.length} Files",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigationProvider.navigateTo(context, '/pdfFiles');
                },
                child: Container(
                  height: 74,
                  width: 142,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 167, 167, 170)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // color: const Color(0xff57CAEB),
                              color: Colors.redAccent),
                          child: const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                            size: 20,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "PDF Files",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${pdfFiles.length} Files",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  navigationProvider.navigateTo(context, '/docxFiles');
                },
                child: Container(
                  height: 74,
                  width: 142,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 167, 167, 170)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff0771b4),
                          ),
                          child: const Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 20,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "Docx Files",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${docFiles.length} Files",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigationProvider.navigateTo(context, "/documentScr");
                },
                child: Container(
                  height: 74,
                  width: 142,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 167, 167, 170)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff57CAEB),
                          ),
                          child: const Icon(
                            Icons.folder,
                            color: Colors.white,
                            size: 20,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "Documents",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${getpdfFile.length}Files",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
