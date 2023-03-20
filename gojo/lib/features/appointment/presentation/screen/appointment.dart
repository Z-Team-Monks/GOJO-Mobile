import 'package:flutter/material.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/input_fields/text_radio_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import 'package:gojo/Gojo-Mobile-Shared/resources/resources.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  String? monthDropDownValue = "March";

  String _datePickerRadioText(String day, String date) {
    return " \n $day \n \n   $date \n";
  }

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GojoPadding.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(Resources.gojoImages.headShot),
                radius: 60,
              ),
              SizedBox(height: 12),
              Text(
                "Konda nok",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: monthDropDownValue,
                      underline: null,
                      items: [
                        DropdownMenuItem(
                          value: "March",
                          child: Text("March"),
                        ),
                        DropdownMenuItem(
                          value: "December",
                          child: Text("December"),
                        ),
                      ],
                      onChanged: ((value) {
                        setState(() {
                          monthDropDownValue = value;
                        });
                      }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 110,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: GojoTextRadioButton(label: null, items: [
                        _datePickerRadioText("Mon", "1"),
                        _datePickerRadioText("Tue", "2"),
                        _datePickerRadioText("Wed", "3"),
                        _datePickerRadioText("Thu", "4"),
                        _datePickerRadioText("Fri", "5"),
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              GojoTextRadioButton(label: null, items: [
                "9:00 am",
                "10:00 am",
                "11:00 am",
                "12:00 am",
                "2:00 pm",
                "3:00 pm",
                "4:00 pm",
                "5:00 pm",
                "6:00 pm"
              ]),
              SizedBox(height: 30),
              GojoBarButton(
                  title: "Request Appointment",
                  onClick: () {
                    GojoSnackBars.showError(
                        context, "Can't connect to internet");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
