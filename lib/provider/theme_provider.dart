import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isClick = false; // This represents whether the dark mode is enabled
  ThemeMode _themeState = ThemeMode.light;

  ThemeMode get themeState => _themeState;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isClick = prefs.getBool('isClick') ??
        false; // Load isClick value, default to false
    _themeState = isClick
        ? ThemeMode.dark
        : ThemeMode.light; // Set theme based on isClick
    notifyListeners();
  }

  void toggleTheme() async {
    isClick = !isClick;
    _themeState = isClick ? ThemeMode.dark : ThemeMode.light;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isClick', isClick); // Save isClick value to shared preferences
    notifyListeners();
  }
}
















// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends ChangeNotifier {
//   bool isClick = false;
//   ThemeMode _themeState = ThemeMode.light;

//   ThemeMode get themeState => _themeState;

//   ThemeProvider() {
//     _loadTheme();
//   }

//   void _loadTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? isDarkMode = prefs.getBool('isDarkMode');
//     if (isDarkMode != null) {
//       _themeState = isDarkMode ? ThemeMode.dark : ThemeMode.light;
//       notifyListeners();
//     }
//   }

//   void setTheme() async {
//     final isLight = _themeState == ThemeMode.dark;
//     if (isLight) {
//       _themeState = ThemeMode.light;
//     } else {
//       _themeState = ThemeMode.dark;
//     }
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkMode', _themeState == ThemeMode.dark);
//     notifyListeners();
//   }
// }
















// // import 'package:flutter/material.dart';

// // class ThemeProvider extends ChangeNotifier {
// //     bool isClick = false;

// //   var _themeState = ThemeMode.light;
// //   ThemeMode get themeState => _themeState;
// //   void setTheme() {
// //     final isLight = _themeState == ThemeMode.dark;
// //     if (isLight) {
// //       _themeState = ThemeMode.light;
// //     } else {
// //       _themeState = ThemeMode.dark;
      
// //     }
// //     notifyListeners();
// //   }
// // }
