import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static const Color _primary = Color(0xff3F80FF);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xff001640),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff001640)),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: _primary);
            }
            return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff8C99B2));
          }),
        ),
        iconTheme: const IconThemeData(color: Color(0xff001640)),
        dividerTheme: const DividerThemeData(
            color: Color(0xffE8EDF5), thickness: 1),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? _primary
                  : const Color(0xffDDE3EE)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        textTheme:
            GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff0A0A0A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff0A0A0A),
          foregroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xff111111),
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: _primary);
            }
            return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff8C99B2));
          }),
        ),
        iconTheme: const IconThemeData(color: Color(0xffA8B8D8)),
        dividerTheme: const DividerThemeData(
            color: Color(0xff1A1A2E), thickness: 1),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? _primary
                  : const Color(0xff2A3550)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        textTheme:
            GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      );
}
