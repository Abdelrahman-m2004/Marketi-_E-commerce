import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppFonts {
  static const String _fontFamily = 'Poppins';
  static TextStyle displayLarge = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headingLarge = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headingMedium = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleLarge = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle buttonLarge = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyLarge = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMedium = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle captionBold = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle fontMedium = GoogleFonts.getFont(
    _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
