
import 'package:flutter/material.dart';
import 'package:flutter1/themes/dark_mode.dart';
import 'package:flutter1/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => themeData == darkTheme;
  
  set themeData (ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if (_themeData == darkTheme){
      themeData = lightTheme;
    }
    else {
      themeData = darkTheme;
    }
  }
}