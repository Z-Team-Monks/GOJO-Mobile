import 'package:flutter/material.dart';
import 'package:gojo/features/auth/otp/presentation/otp_view.dart';
import 'package:gojo/features/applications/presentation/screen/applications_view.dart';

import '../app.dart';
import '../constants/strings/app_routes.dart';
import '../features/appointments/presentation/screen/my_appointments_view.dart';
import '../features/auth/register/presentation/screen/register_view.dart';
import '../features/auth/signin/presentation/screen/signin_view.dart';
import '../features/home/presentation/screen/home_view.dart';
import '../features/map/presentation/screen/map_view.dart';
import '../features/messages/chat/presentation/screen/chat_view.dart';
import '../features/messages/contacts/presentation/screen/contacts_view.dart';
import '../features/property/detail/presentation/screen/detail.dart';
import 'args/chat_args.dart';
import '../features/virtual_tour/presentation/screen/virutal_tour.dart';
import '../root.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GojoRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case GojoRoutes.propertyDetail:
        return MaterialPageRoute(builder: (_) => const DetailPage());
      case GojoRoutes.virtualTour:
        return MaterialPageRoute(builder: (_) => const VirtualTourView());
      case GojoRoutes.signin:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case GojoRoutes.contacts:
        return MaterialPageRoute(builder: (_) => const ContactsView());
      case GojoRoutes.chat:
        final args = settings.arguments as ChatArgs;
        return MaterialPageRoute(
            builder: (_) => ChatView(messages: args.messages));
      case GojoRoutes.root:
        return MaterialPageRoute(builder: (_) => const RootView());
      case GojoRoutes.app:
        return MaterialPageRoute(builder: (_) => const App());
      case GojoRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case GojoRoutes.otp:
        return MaterialPageRoute(builder: (_) => const OTPView());
      case GojoRoutes.map:
        return MaterialPageRoute(builder: (_) => const MapView());
      case GojoRoutes.myAppointments:
        return MaterialPageRoute(builder: (_) => const MyAppointmentsView());
      case GojoRoutes.applications:
        return MaterialPageRoute(builder: (_) => const ApplicationsView());
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
