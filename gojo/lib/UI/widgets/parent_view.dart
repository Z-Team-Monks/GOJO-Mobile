import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/padding.dart';
import 'package:gojo/UI/widgets/app_icon.dart';
import 'package:gojo/resources/resources.dart';

class GojoParentView extends StatelessWidget {
  final Widget child;

  const GojoParentView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gojo",
          style: TextStyle(
            color: Resources.gojoColors.primaryContrastColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: GojoPadding.extraSmall),
          child: child,
        ),
      ),
    );
  }
}
