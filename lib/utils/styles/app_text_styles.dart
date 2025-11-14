import 'package:flutter/material.dart';

class AppTextStyles {
  // Font families
  static const String regular = 'Regular';
  static const String medium = 'Medium';
  static const String bold = 'Bold';

  // Headline styles
  static TextStyle get headline1 => const TextStyle(
        fontFamily: bold,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get headline2 => const TextStyle(
        fontFamily: bold,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get headline3 => const TextStyle(
        fontFamily: bold,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get headline4 => const TextStyle(
        fontFamily: medium,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get headline5 => const TextStyle(
        fontFamily: medium,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get headline6 => const TextStyle(
        fontFamily: medium,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
      );

  // Body text styles
  static TextStyle get bodyText1 => const TextStyle(
        fontFamily: regular,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get bodyText2 => const TextStyle(
        fontFamily: regular,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get subtitle1 => const TextStyle(
        fontFamily: medium,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF2C3E50),
      );

  static TextStyle get subtitle2 => const TextStyle(
        fontFamily: medium,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF2C3E50),
      );

  // Button text styles
  static TextStyle get button => const TextStyle(
        fontFamily: medium,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Caption and overline
  static TextStyle get caption => const TextStyle(
        fontFamily: regular,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0xFF7F8C8D),
      );

  static TextStyle get overline => const TextStyle(
        fontFamily: medium,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Color(0xFF7F8C8D),
        letterSpacing: 1.5,
      );

  // Custom styles with primary color
  static TextStyle get primaryHeading => const TextStyle(
        fontFamily: bold,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF117D65),
      );

  static TextStyle get primaryButton => const TextStyle(
        fontFamily: medium,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF117D65),
      );
}
