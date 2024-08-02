import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'widgets/appbar.dart';
import 'widgets/custom_container.dart';

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
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adunit = "ca-app-pub-3940256099942544/9214589741";
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adunit,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        }, onAdFailedToLoad: ((ad, error) {
          ad.dispose();
          print(error);
        })),
        request: AdRequest());
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Text(
              "Dashboard Files",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            CustomSearchBar(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Recently",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            CustomContainers(),
            SizedBox(
              height: 50,
            ),
            isAdLoaded
                ? SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  )
                : SizedBox(
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

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xffF2F7FF)),
        child: TextFormField(
          // focusNode: _focusNode
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconColor: Color.fromARGB(255, 127, 127, 131),
              labelText: 'Search Store',
              labelStyle: TextStyle(color: Color(0xff9694FF)),
              prefixIcon: const Icon(
                Icons.search,
                size: 25,
              )),
        ),
      ),
    );
  }
}
