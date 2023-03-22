import 'package:flutter/material.dart';
import 'package:gojo/app.dart';
import 'package:gojo/features/auth/regiser/presentation/screen/register_view.dart';
import 'package:gojo/features/appointment/presentation/screen/appointment.dart';
import 'package:gojo/features/auth/signin/presentation/screen/signin_view.dart';
import 'package:gojo/features/detail/presentation/detail.dart';
import 'package:gojo/features/home/presentation/screen/home_view.dart';
import 'package:gojo/features/messages/chat/presentation/screen/chat_view.dart';
import 'package:gojo/features/messages/contacts/presentation/screen/contacts_view.dart';
import 'package:gojo/constants/strings/app_routes.dart';
import 'package:gojo/features/virtual_tour/presentation/screen/virutal_tour.dart';
import 'package:gojo/root.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GojoRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case GojoRoutes.propertyDetail:
        return MaterialPageRoute(builder: (_) => const DetailPage());
      case GojoRoutes.appointment:
        return MaterialPageRoute(builder: (_) => const AppointmentView());
      case GojoRoutes.virtualTour:
        return MaterialPageRoute(builder: (_) => const VirtualTourView());
      case GojoRoutes.signin:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case GojoRoutes.contacts:
        return MaterialPageRoute(builder: (_) => const ContactsView());
      case GojoRoutes.chat:
        return MaterialPageRoute(builder: (_) => const ChatView());
      case GojoRoutes.root:
        return MaterialPageRoute(builder: (_) => const RootView());
      case GojoRoutes.app:
        return MaterialPageRoute(builder: (_) => const App());
      case GojoRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
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
