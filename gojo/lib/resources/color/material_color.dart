import 'package:flutter/material.dart';
import 'package:gojo/resources/color/colors.dart';

class AppMaterialColor {
  final Color color;

  AppMaterialColor(this.color);

  MaterialColor get materialColor {
    return MaterialColor(color.value, <int, Color>{
      50: color,
      100: color,
      200: color,
      300: color,
      400: color,
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
    });
  }
}
