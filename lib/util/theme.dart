import 'package:flutter/material.dart';

class CustomTheme {
  static const Color seedcolor = Color.fromARGB(255, 1, 157, 19);

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
