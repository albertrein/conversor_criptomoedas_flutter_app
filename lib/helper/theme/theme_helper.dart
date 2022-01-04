import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

enum ConfigItens{setAppBarBackgroundColor, setBodyBackgroundColor}

class ThemeConfig{
  void setNewColor(ConfigItens enumConfigThemeType, int newColor){
    switch(enumConfigThemeType){
      case ConfigItens.setAppBarBackgroundColor:
        _setAppBarBackgroundColor(newColor);
        break;
      case ConfigItens.setBodyBackgroundColor:
        _setBodyBackgroundColor(newColor);
        break;
    }
  }

  static Future<int> get getAppBarBackgroundColor async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    try{
      return configLocal.getInt('appBarBackgroundColor') ?? 4278190080;
    }on Exception{
      return 4278190080;
    }
  }  
  void _setAppBarBackgroundColor(int novaCor) async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    await configLocal.setInt('appBarBackgroundColor', novaCor);
  }

  static Future<int> get getBodyBackgroundColor async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    try{
      return configLocal.getInt('bodyBackgroundColor') ?? 4278190080;
    }on Exception{
      return 4278190080;
    }
  }  
  void _setBodyBackgroundColor(int novaCor) async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    await configLocal.setInt('bodyBackgroundColor', novaCor);
  }
}