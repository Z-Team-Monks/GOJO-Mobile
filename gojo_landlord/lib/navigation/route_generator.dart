import 'package:flutter/material.dart';
import 'package:gojo_landlord/app.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';
import 'package:gojo_landlord/features/auth/signin/presentation/screen/signin_view.dart';
import 'package:gojo_landlord/features/messages/chat/presentation/screen/chat_view.dart';
import 'package:gojo_landlord/features/requests/appointements/appointments.dart';
import 'package:gojo_landlord/root.dart';
import 'package:gojo_landlord/features/requests/applications/requests.dart';
import 'package:gojo_landlord/features/withdrawal/withdrawal.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GojoRoutes.app:
        return MaterialPageRoute(builder: (_) => const App());
      case GojoRoutes.signin:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case GojoRoutes.root:
        return MaterialPageRoute(builder: (_) => const RootView());
      case GojoRoutes.chat:
        return MaterialPageRoute(builder: (_) => const ChatView());
      case GojoRoutes.requests:
        return MaterialPageRoute(builder: (_) => const RequestsPage());
      case GojoRoutes.appointments:
        return MaterialPageRoute(builder: (_) => const AppointmentsView());
      case GojoRoutes.withdraw:
        return MaterialPageRoute(builder: (_) => const WithdrawRequest());
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
