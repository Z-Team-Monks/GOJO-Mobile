import 'package:flutter/material.dart';
import 'package:gojo/features/appointment/my_appointments/presentation/my_appointment_view.dart';
import 'package:gojo/features/auth/otp/presentation/otp_view.dart';

import '../app.dart';
import '../constants/strings/app_routes.dart';
import '../features/appointment/make_appointment/presentation/screen/appointment.dart';
import '../features/auth/register/presentation/screen/register.dart';
import '../features/auth/signin/presentation/screen/signin_view.dart';
import '../features/detail/presentation/detail.dart';
import '../features/home/presentation/screen/home_view.dart';
import '../features/map/presentation/map_view.dart';
import '../features/messages/chat/presentation/screen/chat_view.dart';
import '../features/messages/contacts/presentation/screen/contacts_view.dart';
import '../features/virtual_tour/presentation/screen/virutal_tour.dart';
import '../root.dart';

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
      case GojoRoutes.otp:
        return MaterialPageRoute(builder: (_) => const OTPView());
      case GojoRoutes.map:
        return MaterialPageRoute(builder: (_) => const MapView());
      case GojoRoutes.myAppointments:
        return MaterialPageRoute(builder: (_) => const MyAppointmentsView());
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
