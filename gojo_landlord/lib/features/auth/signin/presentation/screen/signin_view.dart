import 'package:flutter/material.dart';
import 'package:gojo_landlord/constants/strings/app_routes.dart';
import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/app_icon.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/text_link.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const GojoAppIcon(),
            const SizedBox(height: 50),
            Column(
              children: [
                Text(
                  "Welcome to Gojo!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text("Elevate your rental business with us!")
              ],
            ),
            const SizedBox(height: 30),
            const GojoTextField(
              labelText: "Phone number",
            ),
            const SizedBox(height: 15),
            const GojoTextField(
              labelText: "Password",
              isObscure: true,
            ),
            const SizedBox(height: 30),
            GojoBarButton(
              title: "Login",
              onClick: (() {
                // Navigator.pushNamed(context, GojoRoutes.signin);
              }),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                const SizedBox(width: 5),
                TextLink(
                  label: "Register",
                  onClick: () {},
                )
              ],
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
