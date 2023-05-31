import 'package:flutter/material.dart';
import 'package:gojo_landlord/features/requests/appointments/presentation/screen/my_appointments_view.dart';

import '../app.dart';
import '../constants/strings/app_routes.dart';
import '../features/auth/signin/presentation/screen/signin_view.dart';
import '../features/messages/chat/presentation/screen/chat_view.dart';
import '../features/requests/applications/requests.dart';
import '../features/wallet/withdrawal.dart';
import '../root.dart';
import 'args/chat_args.dart';

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
        final args = settings.arguments as ChatArgs;
        return MaterialPageRoute(
          builder: (_) => ChatView(
            messages: args.messages,
            tenant: args.tenant,
          ),
        );
      case GojoRoutes.requests:
        return MaterialPageRoute(builder: (_) => const RequestsPage());
      case GojoRoutes.appointments:
        return MaterialPageRoute(builder: (_) => const MyAppointmentsView());
      case GojoRoutes.withdraw:
        return MaterialPageRoute(builder: (_) => const WalletView());
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
