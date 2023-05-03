import 'package:flutter/material.dart';
import 'package:gojo_landlord/locator.dart';
import 'package:gojo_landlord/navigation/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Gojo-Mobile-Shared/resources/resources.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes repositories using get_it.
  Locator.setup();

  runApp(
    MaterialApp(
      title: 'Gojo Landlord',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Resources.gojoColors.primaryMaterialColor.materialColor,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ),
  );
}
