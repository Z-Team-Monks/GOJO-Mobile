import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/app.dart';
import 'package:gojo/features/detail/presentation/detail.dart';
import 'package:gojo/navigation/route_generator.dart';
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
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  );
}
