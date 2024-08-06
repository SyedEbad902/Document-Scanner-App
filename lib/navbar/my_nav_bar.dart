import 'package:flutter/material.dart';

import '../pages/Home/home_screen.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int currentIndex = 0;
  List screens = [
    const HomeScreen(),
    const Scaffold(),
    const Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       currentIndex = 0;
      //     });
      //   },
      //   shape: const CircleBorder(),
      //   backgroundColor: const Color.fromARGB(255, 255, 156, 7),
      //   child: const Icon(
      //     Icons.home,
      //     size: 30,
      //     color: Colors.white,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              offset: const Offset(0, 3), // Offset in x and y direction
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Circular border
          child: BottomAppBar(
            color: Colors.white,
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
                      color: currentIndex == 0 ? Colors.blue : Colors.grey,
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
                      color: currentIndex == 1 ? Colors.red : Colors.grey,
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
                      color: currentIndex == 3 ? Colors.blue : Colors.grey,
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