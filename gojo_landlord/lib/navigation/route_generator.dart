import 'package:flutter/material.dart';
import 'package:gojo_landlord/features/auth/register/presentation/screen/register_view.dart';
import 'package:gojo_landlord/features/property/create_property/presentation/screen/edit_property_view.dart';
import 'package:gojo_landlord/navigation/args/applications_args.dart';
import 'package:gojo_landlord/navigation/args/appointments_args.dart';

import '../app.dart';
import '../constants/strings/app_routes.dart';
import '../features/auth/forgotPassword/presentation/screen/forgot_password_view.dart';
import '../features/auth/forgotPassword/presentation/screen/get_phone_view.dart';
import '../features/auth/otp/presentation/screen/otp_view.dart';
import '../features/auth/signin/presentation/screen/signin_view.dart';
import '../features/messages/chat/presentation/screen/chat_view.dart';
import '../features/requests/applications/presentation/screen/application_requests_view.dart';
import '../features/requests/appointments/presentation/screen/my_appointments_view.dart';
import '../features/wallet/presentation/screen/wallet_view.dart';
import '../root.dart';
import 'args/chat_args.dart';
import 'args/edit_property_args.dart';
import 'args/otp_args.dart';

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
        final args = settings.arguments as ApplicationsArgs;
        return MaterialPageRoute(
          builder: (_) => ApplicationRequestsView(propertyId: args.propertyId),
        );
      case GojoRoutes.appointments:
        final args = settings.arguments as AppointmentArgs;
        return MaterialPageRoute(
          builder: (_) => MyAppointmentsView(propertyId: args.propertyId),
        );
      case GojoRoutes.otp:
        final args = settings.arguments as OtpArgs;
        return MaterialPageRoute(
          builder: (_) => OTPView(phone: args.phone),
        );
      case GojoRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterView(),
        );
      case GojoRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const OTPForgotPasswordView());
      case GojoRoutes.resetPassword:
        final args = settings.arguments as OtpArgs;
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordView(phoneNumber: args.phone),
        );
      case GojoRoutes.withdraw:
        return MaterialPageRoute(builder: (_) => const WalletView());
      case GojoRoutes.editProperty:
        final args = settings.arguments as EditPropertyArgs;
        return MaterialPageRoute(
          builder: (_) => EditPropertyView(propertyItem: args.propertyItem),
        );
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
