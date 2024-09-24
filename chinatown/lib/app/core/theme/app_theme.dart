import 'package:flutter/material.dart';

import 'app_colors.dart';

final appThemeData = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  shadowColor: Colors.grey.shade300,
  backgroundColor: textColor,
  hintColor: secondaryTextColor,
  splashColor: accentColor,
  highlightColor: darkPrimaryColor,
  fontFamily: 'Georgia',
  appBarTheme: const AppBarTheme(color: primaryColor, elevation: 6.0),
  textTheme: const TextTheme(
    // bodyLarge: textStyle(),
    headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
  ),
);
