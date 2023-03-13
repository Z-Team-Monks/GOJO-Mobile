import 'package:flutter/material.dart';
import 'package:gojo/navigation/routeGenerator.dart';
import 'package:gojo/resources/resources.dart';
import 'package:gojo/resources/strings/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Gojo',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Resources.gojoColors.primaryMaterialColor.materialColor,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ),
  );
}
