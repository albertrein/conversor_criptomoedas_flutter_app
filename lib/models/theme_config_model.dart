import 'package:flutter/material.dart';

class ThemeConfigData{
  late int backgroundAppBarColor;
  late int backgroundBodyColor;

  ThemeConfigData(this.backgroundAppBarColor, this.backgroundBodyColor);

  factory ThemeConfigData.initializer({required int backgroundAppBarColor, required int backgroundBodyColor}) => ThemeConfigData(
    backgroundAppBarColor = backgroundAppBarColor,
    backgroundBodyColor = backgroundBodyColor
  );  

  void setBackgroundAppBarColor(int newBackgroundAppBarColor){
    backgroundAppBarColor = newBackgroundAppBarColor;
  }
  
  void setBackgroundBodyColor(int newBackgroundBodyColor){
    backgroundBodyColor = newBackgroundBodyColor;
  }

  Color get getBackgroundAppBarColor => Color(backgroundBodyColor);
  
  Color get getBackgroundBodyColor => Color(backgroundBodyColor);
  
}