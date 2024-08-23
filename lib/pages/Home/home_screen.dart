// ignore_for_file: avoid_print, unnecessary_null_comparison
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf_scanner/provider/home_screen_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/appbar.dart';
import 'widgets/custom_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool dataLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      if (!dataLoaded) {
        if (Provider.of<HomeProvider>(context, listen: false).files.isEmpty) {
          Provider.of<HomeProvider>(context, listen: false).searchFiles();
        }
        if (Provider.of<HomeProvider>(context, listen: false)
                .docFiles
                .isEmpty &&
            Provider.of<HomeProvider>(context, listen: false)
                .pdfFiles
                .isEmpty) {
          Timer(const Duration(milliseconds: 500), () {
            Provider.of<HomeProvider>(context, listen: false).filesCheck();
          });
        }
        if (Provider.of<HomeProvider>(context, listen: false)
            .pdfPreviews
            .isNotEmpty) {
          Provider.of<HomeProvider>(context, listen: false).pdfPreviews.clear();
          Provider.of<HomeProvider>(context, listen: false).pdfFilesPaths.clear();
          Provider.of<HomeProvider>(context, listen: false).loadFiless();
          Provider.of<HomeProvider>(context, listen: false).loadFiles();
        } else {
          Provider.of<HomeProvider>(context, listen: false).loadFiless();
          Provider.of<HomeProvider>(context, listen: false).loadFiles();
        }

        dataLoaded = true;
      }
    });

    initBannerAd();
    // _loadFiles();
  }

////////////////////////get pdf docs///////////////////////////
  // Uint8List? previewImage;

  // // List<File> _files = [];
  // List<Map<String, dynamic>> pdfPreviews = [];
  // Future<void> _loadFiles() async {
  //   // const directoryPath = "/data/user/0/com.example.pdf_scanner/app_flutter";
  //   const directoryPath =
  //       "/data/user/0/com.example.pdf_scanner/cache/mlkit_docscan_ui_client";
  //   final directory = Directory(directoryPath);

  //   if (await directory.exists()) {
  //     final List<FileSystemEntity> entities = await directory.list().toList();
  //     final List<File> files = entities.whereType<File>().toList();

  //     for (File file in files) {
  //       final previewImage = await _renderFirstPage(file.path);
  //       if (previewImage != null) {
  //         // setState(() {
  //         pdfPreviews.add({
  //           'path': file.path,
  //           'preview': previewImage,
  //         });
  //         // });
  //       }
  //     }
  //     setState(() {});
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
////////////////////////////////////////////////////////////////

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adunit = "ca-app-pub-3940256099942544/9214589741";
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: adunit,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        }, onAdFailedToLoad: ((ad, error) {
          ad.dispose();
          print(error);
          showToast("Failed to load ad");
        })),
        request: const AdRequest());
    bannerAd.load();
  }

/////////////// getting files from device/////////////////////////////////
  // List<String> pdfFiles = [];
  // List<String> docFiles = [];
  // filesCheck() async {
  //   //  String extension = p.extension(files).toLowerCase();
  //   if (files != null) {
  //     for (var i = 0; i < files.length; i++) {
  //       String extension = p.extension(files[i]).toLowerCase();
  //       if (extension == ".pdf") {
  //         pdfFiles.add(files[i]);
  //       } else {
  //         docFiles.add(files[i]);
  //       }
  //     }
  //     setState(() {});
  //   } else {
  //     print("Error");
  //   }
  // }

////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final provider = HomeProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const Text(
                "Dashboard Files",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              // const CustomSearchBar(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Recently",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              CustomContainers(
                getfiles: provider.files,
                getpdfFile: provider.pdfFilesPaths,
                pdfFiles: provider.pdfFiles,
                docFiles: provider.docFiles,
              ),
              const SizedBox(
                height: 40,
              ),
              isAdLoaded
                  ? Center(
                      child: SizedBox(
                        height: bannerAd.size.height.toDouble(),
                        width: bannerAd.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd),
                      ),
                    )
                  : const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff9694FF),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
