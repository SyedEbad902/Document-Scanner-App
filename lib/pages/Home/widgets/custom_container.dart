import 'package:flutter/material.dart';

class CustomContainers extends StatelessWidget {
  const CustomContainers({
    super.key,
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
              Container(
                height: 74,
                width: 142,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 167, 167, 170)),
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
                          color: Color(0xff9694FF),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "Personal",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "120 Files",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )),
                      ],
                    )
                  ],
                )),
              ),
              Container(
                height: 74,
                width: 142,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 167, 167, 170)),
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
                          color: Color(0xffFF7976),
                        ),
                        child: Icon(
                          Icons.folder,
                          color: Colors.white,
                          size: 20,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "Documents",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "15 Files",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )),
                      ],
                    )
                  ],
                )),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 74,
                width: 142,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 167, 167, 170)),
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
                          color: Color(0xff5DDAB4),
                        ),
                        child: Icon(
                          Icons.pause_circle_filled,
                          color: Colors.white,
                          size: 20,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "Videos",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "15 Files",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )),
                      ],
                    )
                  ],
                )),
              ),
              Container(
                height: 74,
                width: 142,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 167, 167, 170)),
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
                          color: Color(0xff57CAEB),
                        ),
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 20,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "Gallery",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "15 Files",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            )),
                      ],
                    )
                  ],
                )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
