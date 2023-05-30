import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/core/repository/user_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'features/route_guard/presentation/bloc/route_guard_bloc.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'navigation/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes repositories using get_it.
  await Locator.setup();

  // Initialize firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => RouteGuardBloc(
        GetIt.I<UserRepositoryAPI>(),
      )..add(
          LoadRouteGuardStatus(),
        ),
      child: MaterialApp(
        title: 'Gojo Landlord',
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          primarySwatch:
              Resources.gojoColors.primaryMaterialColor.materialColor,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
