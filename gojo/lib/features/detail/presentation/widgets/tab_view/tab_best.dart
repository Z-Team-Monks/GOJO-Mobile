import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';
import 'package:gojo/UI/design_tokens/borders.dart';
import 'package:gojo/constants/strings/app_routes.dart';

class TabBest extends StatelessWidget {
  const TabBest({Key? key}) : super(key: key);

  Widget buildButton(
    String label, {
    onPressed,
    isActive = false,
    IconData? iconData,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 13.5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: GojoBorders.border(GojoBorderRadiusSize.small),
            color: Resources.gojoColors.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Resources.gojoColors.primaryContrastColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                iconData != null
                    ? Icon(
                        iconData,
                        size: 16,
                        color: Resources.gojoColors.primaryContrastColor,
                      )
                    : Container()
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildButton("Directions"),
        buildButton("Request Appointment", iconData: Icons.calendar_today,
            onPressed: () {
          Navigator.pushNamed(context, GojoRoutes.appointment);
        }),
        buildButton("Message", iconData: Icons.message),
        buildButton("Apply For Rent", iconData: Icons.add_card_rounded),
      ],
    );
  }
}
