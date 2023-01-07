import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.green, // Your accent color
  ),
    backgroundColor: Colors.white,
    fontFamily: 'Georgia',
    textTheme: TextTheme(
        headline1: TextStyle(fontSize: 50),
        headline6: TextStyle(fontSize: 15.0),
        bodyText2: TextStyle(fontSize: 10.0),),);


class AppTheme with ChangeNotifier {


  ThemeMode get themeMode =>  ThemeMode.light;

}
AppTheme appTheme = AppTheme();



