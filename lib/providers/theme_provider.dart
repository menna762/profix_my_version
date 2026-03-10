import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.light;
  void changeTheme(ThemeMode newMode){
    if(appTheme==newMode){
      return;

    }
    appTheme=newMode;
    notifyListeners();
  }
  bool isDarkTheme(){
    return appTheme==ThemeMode.dark;
  }
}