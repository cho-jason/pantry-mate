import 'package:flutter/material.dart';

ThemeData buildTheme() {
  // Define font styles with this method
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
        headline: base.headline.copyWith(
            fontSize: 40.0, color: Colors.white /* const Color(0xFF807a6b) */));
  }

  // Override a default light blue theme
  final ThemeData base = ThemeData.light();

  // Apply changes to it
  return base.copyWith(textTheme: _buildTextTheme(base.textTheme));
}
