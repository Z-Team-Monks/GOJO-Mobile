import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';

class TabBest extends StatelessWidget {
  const TabBest({Key? key}) : super(key: key);

  Widget _buildButton(
    String label, {
    onPressed,
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
    Future<void> showApplyForRentDialogue() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Are you sure you want to apply?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        _buildButton("Directions"),
        _buildButton(
          "Request Appointment",
          iconData: Icons.calendar_today,
          onPressed: () {
            Navigator.pushNamed(context, GojoRoutes.appointment);
          },
        ),
        _buildButton(
          "Message",
          iconData: Icons.message,
          onPressed: () {
            Navigator.pushNamed(context, GojoRoutes.chat);
          },
        ),
        _buildButton(
          "Apply For Rent",
          iconData: Icons.add_card_rounded,
          onPressed: () {
            showApplyForRentDialogue();
          },
        ),
      ],
    );
  }
}
