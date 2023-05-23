import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/core/repository/user_repository.dart';
import 'package:gojo/features/route_guard/presentation/bloc/route_guard_bloc.dart';
import 'package:gojo/locator.dart';
import 'package:gojo/navigation/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes shared objects using getit.
  await Locator.setup();

  // Initialize firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    OverlaySupport(
      child: BlocProvider(
        create: (context) => RouteGuardBloc(
          GetIt.I<UserRepositoryAPI>(),
        )..add(
            LoadRouteGuardStatus(),
          ),
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
    ),
  );
}
