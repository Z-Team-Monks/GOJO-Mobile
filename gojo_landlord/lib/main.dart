import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'locator.dart';
import 'navigation/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes repositories using get_it.
  Locator.setup();

  runApp(
    MaterialApp(
      title: 'Gojo Landlord',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Resources.gojoColors.primaryMaterialColor.materialColor,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ),
  );
}
