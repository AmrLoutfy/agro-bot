import 'package:flutter/material.dart';

class MainTheme {
  static Color LightPrimary = Color(0xff37B943);
  static Color blueMain=Color(0xff007197);
  static Color LightGreen = Color(0xff8DE896);
  static Color UnSlctColor = Color(0xff07441F);
  static Color SlctColor = Colors.white;
  static Color LightSec=Color(0xff528265);

  static Color darkBlue=Color(0xff0B3748);
  static ThemeData lightMode = ThemeData(
      primaryColor: LightPrimary,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),

          elevation: 0,
          backgroundColor: Colors.transparent),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey,
          selectedItemColor: LightGreen,
          backgroundColor: darkBlue),
      textTheme: TextTheme(
          titleLarge: TextStyle(
            color: LightGreen,
            backgroundColor: Colors.transparent,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
          color: LightGreen,
          backgroundColor: Colors.transparent,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: Colors.black,
          backgroundColor: Colors.transparent,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ));

}
