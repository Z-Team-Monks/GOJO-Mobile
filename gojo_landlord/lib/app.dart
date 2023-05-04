import 'package:flutter/material.dart';

import 'Gojo-Mobile-Shared/UI/widgets/splash.dart';
import 'features/auth/signin/presentation/screen/signin_view.dart';

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
