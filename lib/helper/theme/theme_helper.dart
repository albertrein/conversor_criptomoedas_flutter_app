import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

enum ConfigItens{setAppBarBackgroundColor}

class ThemeConfig{
  static Future<int> get getAppBarBackgroundColor async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    try{
      return configLocal.getInt('appBarBackgroundColor') ?? 4294967295;
    }on Exception{
      return 4294967295;
    }
  } 
  
  void _setAppBarBackgroundColor(int novaCor) async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    await configLocal.setInt('appBarBackgroundColor', novaCor);
  }

  void setNewColor(ConfigItens enumConfigThemeType, int newColor){
    switch(enumConfigThemeType){
      case ConfigItens.setAppBarBackgroundColor:
        _setAppBarBackgroundColor(newColor);
        break;
    }
  }
}