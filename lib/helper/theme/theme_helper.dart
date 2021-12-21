import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfig{

  static Future<Color> get getAppBarBackgroundColor async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    return Color((configLocal.getInt('appBarBackgroundColor') ?? 4294967295));
  }  
  
  static void setAppBarBackgroundColor(int novaCor) async {
    SharedPreferences configLocal = await SharedPreferences.getInstance();
    await configLocal.setInt('appBarBackgroundColor', novaCor);
  }  
}