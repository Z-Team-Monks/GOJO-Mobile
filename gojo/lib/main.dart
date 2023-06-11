import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Gojo-Mobile-Shared/core/repository/user_repository.dart';
import 'Gojo-Mobile-Shared/resources/resources.dart';
import 'Gojo-Mobile-Shared/shared_features/locale/presentation/bloc/app_locale_bloc.dart';
import 'features/route_guard/presentation/bloc/route_guard_bloc.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'navigation/route_generator.dart';

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RouteGuardBloc(
              GetIt.I<UserRepositoryAPI>(),
            )..add(
                LoadRouteGuardStatus(),
              ),
          ),
          BlocProvider(
            create: (context) => AppLocaleBloc(),
          ),
        ],
        child: BlocBuilder<AppLocaleBloc, AppLocaleState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Gojo',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              theme: ThemeData(
                fontFamily: GoogleFonts.nunito().fontFamily,
                primarySwatch:
                    Resources.gojoColors.primaryMaterialColor.materialColor,
              ),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        ),
      ),
    ),
  );
}
