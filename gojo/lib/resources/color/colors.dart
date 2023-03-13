import 'package:flutter/material.dart';
import 'package:gojo/resources/color/material_color.dart';

class GojoColors {
  final Color primaryColor = const Color.fromARGB(255, 27, 181, 92);
  final Color primaryContrastColor = Colors.white;

  final Color? lightGrey = Colors.grey[300];
  final Color? darkGrey = Colors.grey;

  final Color black = Colors.black;

  final AppMaterialColor primaryMaterialColor =
      AppMaterialColor(const Color.fromARGB(255, 27, 181, 92));
}
