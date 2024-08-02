import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_scanner/pages/Home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }  
  @override
  
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Container(
          // color: const Color.fromRGBO(83, 177, 117, 5),
          child: Center(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child:  SvgPicture.asset("assets/images/Splash Screen.svg"),
            ),
          ),
        ),
      ),
    );
  }
}