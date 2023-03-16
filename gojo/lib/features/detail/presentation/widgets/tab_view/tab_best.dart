import 'package:flutter/material.dart';
import 'package:gojo/UI/design_tokens/borders.dart';

class TabBest extends StatelessWidget {
  const TabBest({Key? key}) : super(key: key);

  Widget buildButton(String label,
      {onPressed, isActive = false, IconData? iconData}) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: GojoBorders.border(GojoBorderRadiusSize.small),
          color: Colors.teal,
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
              Text(label),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              iconData != null
                  ? Icon(
                      iconData,
                      size: 16,
                    )
                  : Container()
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildButton("Directions"),
        buildButton("Request Appointment", iconData: Icons.calendar_today),
        buildButton("Call", iconData: Icons.call),
        buildButton("Apply For Rent", iconData: Icons.add_card_rounded),
      ],
    );
  }
}
