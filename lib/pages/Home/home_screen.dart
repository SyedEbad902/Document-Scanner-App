// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Documents page/widgets/search_bar.dart';
import 'widgets/appbar.dart';
import 'widgets/custom_container.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initBannerAd();
    _searchFiles();
  }

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
  List<String> files = [];
  Future<List<String>> _searchFiles() async {
    // Request storage permissions
    if (await Permission.storage.request().isGranted) {
      try {
        // final directory = await getExternalStorageDirectory();
        // final directory = Directory('/storage/emulated/0/Download');
        final directory = Directory(
            '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Documents/');
        if (directory == null) {
          return files;
        }

        // List entities in the directory
        final entities = directory.listSync(recursive: true);
        print('Entities in the directory: $entities');
        for (var entity in entities) {
          if (entity is File) {
            String path = entity.path;
            // print("File found: $path");
            // files.add(path);

            if (path.endsWith('.doc') ||
                path.endsWith('.docx') ||
                path.endsWith('.pdf')) {
              files.add(path);
              print("File found: $path");
            }
          } else {
            print("Skipping non-file entity: ${entity.path}");
          }
        }
        setState(() {});
      } catch (e) {
        showToast("Error Reading Directory");
        print('Error reading directory: $e');
      }
    } else {
      showToast('Storage permission denied');

      print('Storage permission denied');
    }

    print('Files found: $files');
    return files;
  }

////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
            const CustomSearchBar(),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Recently",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            CustomContainers(getfiles: files),
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
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
