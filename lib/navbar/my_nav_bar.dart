import 'package:flutter/material.dart';
import 'package:pdf_scanner/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../pages/Account page/accounts.dart';
import '../pages/Home/home_screen.dart';
import '../pages/Scanning/image_scan.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int currentIndex = 0;
  List screens = [const HomeScreen(), const DocScanner(), const Accounts()];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isClick ? Color(0xff121212) : Colors.white,
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 5), // Offset in x and y direction
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Circular border
          child: BottomAppBar(
            color:
                themeProvider.isClick ? const Color(0xff1e1e1e) : Colors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    icon: Icon(
                      Icons.grid_view_outlined,
                      size: 30,
                      color: currentIndex == 0
                          ? themeProvider.isClick
                              ? const Color(0xff5A5899)
                              : const Color(0xff9694FF)
                          : themeProvider.isClick
                              ? Colors.white
                              : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    icon: Icon(
                      Icons.document_scanner_outlined,
                      size: 30,
                      color: currentIndex == 1
                          ? themeProvider.isClick
                              ? const Color(0xff5A5899)
                              : const Color(0xff9694FF)
                          : themeProvider.isClick
                              ? Colors.white
                              : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    icon: Icon(
                      Icons.person_2_outlined,
                      size: 35,
                      color: currentIndex == 2
                          ? themeProvider.isClick
                              ? const Color(0xff5A5899)
                              : const Color(0xff9694FF)
                          : themeProvider.isClick
                              ? Colors.white
                              : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
