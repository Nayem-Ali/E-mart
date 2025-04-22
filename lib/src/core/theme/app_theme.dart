import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue.shade800,
      colorScheme: ColorScheme.light(
        primary: Colors.blue.shade800,
        secondary: Colors.orange.shade600,
        surface: Colors.white,
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Intel', // Add font family
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Intel',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),

        bodyLarge: TextStyle(
          fontFamily: 'Intel',
          fontSize: 16,
          fontWeight: FontWeight.normal, // Regular weight
          color: Colors.grey.shade800,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Intel',
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.grey.shade700,
        ),

        labelLarge: TextStyle(
          fontFamily: 'Intel',
          fontSize: 16,
          fontWeight: FontWeight.w500, // Medium weight
          color: Colors.white,
        ),

        titleLarge: TextStyle(
          fontFamily: 'Intel',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Intel',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Intel',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black.withOpacity(0.8),
        ),
      ),
    );
  }
}
