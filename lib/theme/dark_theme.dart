import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData nightBreakDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(
    surface: Colors.black,
    primary: Colors.grey.shade400,
    secondary: Colors.blueGrey,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lora(
      // this is causing hot reload to break for some reason?
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade200,
    ),
    headlineMedium: GoogleFonts.inter(
      color: Colors.grey.shade400,
    ),
    headlineSmall: GoogleFonts.lora(
      color: Colors.grey.shade400,
    ),
    bodyLarge: GoogleFonts.inter(
      color: Colors.grey.shade400,
    ),
    labelMedium: GoogleFonts.inter(
      color: Colors.grey.shade400,
      fontWeight: FontWeight.w300,
    ),
  ),
);
