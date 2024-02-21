import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData nightBreakDarkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade200,
    secondary: Colors.blueGrey,
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lora(
      // this is causing hot reload to break for some reason?
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: GoogleFonts.inter(),
    headlineSmall: GoogleFonts.lora(),
    bodyLarge: GoogleFonts.inter(),
    labelMedium: GoogleFonts.inter(
      color: Colors.grey.shade200,
      fontWeight: FontWeight.w300,
    ),
  ),
);
