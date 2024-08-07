import 'package:flutter/material.dart';

import '../../Documents page/documents_screen.dart';
import '../../Personal Files/personal_file.dart';

class CustomContainers extends StatelessWidget {
  final List getfiles;
  const CustomContainers({
    super.key,
    required this.getfiles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GetFiles(
                                getFiles: getfiles,
                              )));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const DocumentScreen())));
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
                            color: const Color(0xffFF7976),
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
                              child: const Text(
                                "15 Files",
                                style: TextStyle(
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
                onTap: () {},
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
                            color: const Color(0xff5DDAB4),
                          ),
                          child: const Icon(
                            Icons.pause_circle_filled,
                            color: Colors.white,
                            size: 20,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "Videos",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "15 Files",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              )),
                        ],
                      )
                    ],
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {},
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
                            Icons.image,
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
                                "Gallery",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: const Text(
                                "15 Files",
                                style: TextStyle(
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
