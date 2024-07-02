import 'package:flutter/material.dart';

ThemeData nightBreakDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: Colors.grey.shade400,
    secondary: Colors.blueGrey,
  ),
  textTheme: TextTheme(
    // displayLarge: TextStyle(
    //   //breaks live update?
    //   fontWeight: FontWeight.w500,
    //   // fontFamily: inter
    //   color: Colors.grey.shade200,
    // ),
    headlineMedium: TextStyle(
      color: Colors.grey.shade400,
    ),
    headlineSmall: TextStyle(
      color: Colors.grey.shade400,
    ),
    bodyLarge: TextStyle(
      color: Colors.grey.shade400,
    ),
    labelMedium: TextStyle(
      color: Colors.grey.shade400,
      fontWeight: FontWeight.w300,
      fontSize: 64.0,
    ),
  ),
);
