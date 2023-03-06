import 'package:flutter/material.dart';
import 'package:gojo/app.dart';
import 'package:gojo/resources/resources.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Gojo',
      theme: ThemeData(
        primarySwatch: Resources.appColors.primaryMaterialColor.materialColor,
      ),
      home: App(),
    ),
  );
}
