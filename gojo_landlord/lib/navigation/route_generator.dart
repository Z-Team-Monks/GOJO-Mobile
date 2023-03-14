import 'package:flutter/material.dart';
import 'package:gojo_landlord/app.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';
import 'package:gojo_landlord/features/auth/signin/presentation/screen/signin_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GojoRoutes.app:
        return MaterialPageRoute(builder: (_) => const App());
      case GojoRoutes.signin:
        return MaterialPageRoute(builder: (_) => const SignInView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
