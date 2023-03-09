import 'package:flutter/material.dart';
import 'package:gojo/app.dart';
import 'package:gojo/resources/resources.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Gojo',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Resources.gojoColors.primaryMaterialColor.materialColor,
      ),
      debugShowCheckedModeBanner: false,
      home: App(),
    ),
  );
}
