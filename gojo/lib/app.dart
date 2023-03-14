import 'package:flutter/material.dart';
import 'Gojo-Mobile-Shared/UI/widgets/splash.dart';
import 'package:gojo/features/auth/signin/presentation/screen/signin_view.dart';

// Logic deciding which screen to go to after splash goes here.
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
