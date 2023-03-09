import 'package:flutter/material.dart';
import 'package:gojo/Features/home/presentation/screen/home_view.dart';
import 'package:gojo/features/auth/signin/presentation/screen/signin_view.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignInView();
  }
}
