import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    // useMaterial3: true,
    // brightness: Brightness.light,
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: _primaryColor,
    //   brightness: Brightness.light,
    //   surface: _lightBackground,
    // ),
    // scaffoldBackgroundColor: Colors.white,
    // appBarTheme: const AppBarTheme(
    //   backgroundColor: Colors.white,
    //   foregroundColor: Color(0xff001640),
    //   elevation: 0,
    //   iconTheme: IconThemeData(color: Color(0xff001640)),
    // ),
    // dividerTheme: const DividerThemeData(
    //   color: Color(0xffE8EDF5),
    //   thickness: 1,
    // ),
    // iconTheme: const IconThemeData(color: Color(0xff001640)),
    // switchTheme: SwitchThemeData(
    //   trackColor: WidgetStateProperty.resolveWith(
    //     (states) => states.contains(WidgetState.selected)
    //         ? _primaryColor
    //         : const Color(0xffDDE3EE),
    //   ),
    // ),
    // textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  );

  static ThemeData get darkTheme => ThemeData(
    // useMaterial3: true,
    // brightness: Brightness.dark,
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: _primaryColor,
    //   brightness: Brightness.dark,
    //   surface: _darkSurface,
    // ),
    // scaffoldBackgroundColor: _darkBackground,
    // appBarTheme: AppBarTheme(
    //   backgroundColor: _darkBackground,
    //   foregroundColor: Colors.white,
    //   elevation: 0,
    //   iconTheme: const IconThemeData(color: Colors.white),
    // ),
    // dividerTheme: const DividerThemeData(
    //   color: _darkDivider,
    //   thickness: 1,
    // ),
    // iconTheme: const IconThemeData(color: Color(0xffA8B8D8)),
    // switchTheme: SwitchThemeData(
    //   trackColor: WidgetStateProperty.resolveWith(
    //     (states) => states.contains(WidgetState.selected)
    //         ? _primaryColor
    //         : const Color(0xff2A3550),
    //   ),
    // ),
    // textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );
}
