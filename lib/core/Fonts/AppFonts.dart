import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppFonts {
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headingLarge = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headingMedium = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle buttonLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle captionBold = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
