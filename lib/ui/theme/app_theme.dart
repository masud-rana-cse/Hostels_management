import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color blue = Color(0xFF0868DF);
  static const Color navy = Color(0xFF063B73);
  static const Color light = Color(0xFFF4F8FC);
  static const Color background = Color(0xFFE9F0F7);
  static const Color line = Color(0xFFDCE8F4);
  static const Color text = Color(0xFF12304D);
  static const Color muted = Color(0xFF6C8197);
  static const Color green = Color(0xFF13A66A);
  static const Color red = Color(0xFFEF4444);
  static const Color orange = Color(0xFFFF9D2E);
  static const Color inputFill = Color(0xFFFBFDFF);
  static const Color cardShadow = Color(0x0E173B5C);
}

class AppTheme {
  static ThemeData get lightTheme => getTheme(AppColors.blue);

  static ThemeData getTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.inter().fontFamily,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.navy),
        titleTextStyle: TextStyle(
          color: AppColors.navy,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
