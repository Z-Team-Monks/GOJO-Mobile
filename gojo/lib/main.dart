import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'locator.dart';
import 'navigation/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes shared objects using getit.
  Locator.setup();

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
