import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/constants/strings/app_routes.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../Gojo-Mobile-Shared/UI/widgets/text_link.dart';

class OTPView extends StatelessWidget {
  const OTPView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      label: "Gojo Verification",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Phone Verification",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "Enter the code from the sms we sent to ",
                  ),
                  TextSpan(
                    text: "+251955211643",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Text(
              "02:32",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Resources.gojoColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 15),
            PinFieldAutoFill(
              currentCode: "123456",
              decoration: BoxLooseDecoration(
                radius: const Radius.circular(5),
                gapSpace: 10,
                strokeColorBuilder: FixedColorBuilder(
                  Resources.gojoColors.primaryColor,
                ),
              ),
              codeLength: 6,
              onCodeChanged: (code) {},
              onCodeSubmitted: (val) {},
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("I didn't receive any code. "),
                TextLink(
                  label: "RESEND",
                  onClick: () {},
                )
              ],
            ),
            const SizedBox(height: 20),
            GojoBarButton(
              title: "Verify",
              onClick: () {
                Navigator.popAndPushNamed(
                  context,
                  GojoRoutes.signin,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
