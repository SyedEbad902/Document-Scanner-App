import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf_scanner/provider/navigation_provider.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
                  Provider.of<NavigationProvider>(context, listen: false).replaceWith(context,'/second');

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const MyNavBar()));
    
    });
  }  
  @override
  
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child:  SvgPicture.asset("assets/images/Splash Screen.svg"),
          ),
        ),
      ),
    );
  }
}