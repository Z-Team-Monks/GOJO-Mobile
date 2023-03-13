import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:gojo/resources/resources.dart';

class GojoSplash extends StatelessWidget {
  final Future<Widget> Function() nextScreen;

  const GojoSplash({
    super.key,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splashIconSize: 100,
      splash: Resources.gojoImages.appIconJpeg,
      screenFunction: nextScreen,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
