import 'package:flutter/material.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/UI/widgets/splash.dart';
import 'package:gojo_landlord/features/auth/signin/presentation/screen/signin_view.dart';
import 'package:gojo_landlord/root.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoSplash(
      nextScreen: () async {
        return const SignInView();
      },
    );
  }
}
