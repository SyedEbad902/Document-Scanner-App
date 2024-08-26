import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
    bool isClick = false;

  var _themeState = ThemeMode.light;
  ThemeMode get themeState => _themeState;
  void setTheme() {
    final isLight = _themeState == ThemeMode.dark;
    if (isLight) {
      _themeState = ThemeMode.light;
    } else {
      _themeState = ThemeMode.dark;
      
    }
    notifyListeners();
  }
}
