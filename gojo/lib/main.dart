import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/features/notification/notification_service.dart';
import 'package:gojo/locator.dart';
import 'package:gojo/navigation/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes shared objects using getit.
  Locator.setup();

  // Initialize firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.setUp();

  runApp(
    OverlaySupport(
      child: MaterialApp(
        title: 'Gojo',
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          primarySwatch:
              Resources.gojoColors.primaryMaterialColor.materialColor,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    ),
  );
}
