
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ColorConstant {
  static const int _deepOrangePrimaryValue = 0xFFFF5722;

  static const MaterialColor crack = MaterialColor(
    _deepOrangePrimaryValue,
    <int, Color>{
      50: Color(0xFF232323),
      100: Color(0xFFE0DED9),
      200: Color(0xFFA670CF),
      300: Color(0xFF4A4A49),
      400: Color(0xFFB4AEB9)
    },
  );
  static ColorSwatch crackBlack = MaterialColor(0xFF232323, <int, Color>{
    50: Color(0xFF232323),
    100: Color(0xFFE0DED9),
    200: Color(0xFFA670CF),
    300: Color(0xFF4A4A49),
    400: Color(0xFFB4AEB9)
  });
  static Color crackBlacks = const Color(0xFF232323);

  static Color crackGrayLight = const Color(0xFFE0DED9);
  static Color crackPurple = const Color(0xFFA670CF);
  static Color crackGrayDark = const Color(0xFF4A4A49);
  static Color crackGrayMedium = const Color(0xFFB4AEB9);

}