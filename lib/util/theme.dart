import 'package:flutter/material.dart';

class CustomTheme {
  static const Color seedcolor = Color(0XFF267365);

  static ThemeData lighttheme = ThemeData(
    fontFamily: 'NotoSansKR-Regular',
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: seedcolor,
  );

  static ThemeData darktheme = ThemeData(
    fontFamily: 'NotoSansKR-Regular',
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: seedcolor,
  );
}
