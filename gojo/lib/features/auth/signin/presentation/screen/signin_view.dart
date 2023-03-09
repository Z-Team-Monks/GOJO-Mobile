import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/padding.dart';
import 'package:gojo/UI/input_fields/text_field.dart';
import 'package:gojo/UI/widgets/app_icon.dart';
import 'package:gojo/UI/widgets/bar_button.dart';
import 'package:gojo/UI/widgets/parent_view.dart';
import 'package:gojo/UI/widgets/text_link.dart';
import 'package:gojo/features/home/presentation/screen/home_view.dart';

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
                Text("Find your next home!")
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
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return HomeView();
                }));
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
