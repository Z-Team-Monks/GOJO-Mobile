import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:gojo/features/auth/register/presentation/screen/widgets/selected_file.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';
import 'widgets/choose_profile.dart';
import 'widgets/data_filled.dart';
import 'widgets/label_row.dart';
import 'widgets/vertical_line.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterView();
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  int currentStep = 1;
  List<Widget> views = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Resources.gojoColors.primaryColor,
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          child: SizedBox(height: 20),
                        ),
                        InkWell(
                          child: LabelRow(
                            step: 1,
                            title: "Personal Information",
                            isSelected: currentStep == 1,
                          ),
                          onTap: () {
                            setState(() {
                              currentStep = 1;
                            });
                          },
                        ),
                        const VerticalLine(visible: true),
                        InkWell(
                          child: LabelRow(
                            step: 2,
                            title: "ID Card",
                            isSelected: currentStep == 2,
                          ),
                          onTap: () {
                            setState(() {
                              currentStep = 2;
                            });
                          },
                        ),
                        const VerticalLine(visible: true),
                        InkWell(
                          child: LabelRow(
                            step: 3,
                            title: "Check and Confirm",
                            isSelected: currentStep == 3,
                          ),
                          onTap: () {
                            setState(() {
                              currentStep = 3;
                            });
                          },
                        ),
                        const VerticalLine(visible: true),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 7,
                child: Container(
                  height: 550,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(17.0),
                      topLeft: Radius.circular(17.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Builder(
                        builder: (context) {
                          switch (currentStep) {
                            case 1:
                              return _buildPersonalInfo(context);
                            case 2:
                              return _buildIdCard(context);
                            default:
                              return _buildCheckAndConfirm(context);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Personal Information",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 15),
        GojoTextField(labelText: "First Name"),
        SizedBox(height: 15),
        GojoTextField(labelText: "Last Name"),
        SizedBox(height: 15),
        GojoTextField(labelText: "Phone"),
        SizedBox(height: 15),
        GojoTextField(labelText: "Password"),
        SizedBox(height: 15),
        GojoTextField(labelText: "Confirm Password"),
        SizedBox(height: 25),
        GojoBarButton(
          title: "Next",
          onClick: () {
            setState(() {
              currentStep = 2;
            });
          },
        ),
      ],
    );
  }

  Widget _buildIdCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Identification Card",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        DashedRect(
          gap: 15,
          strokeWidth: 4,
          color: const Color.fromARGB(150, 27, 181, 92),
          child: Container(
            padding: const EdgeInsets.all(60),
            width: double.infinity,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.cloud_upload,
                size: 70,
                color: Color.fromARGB(150, 27, 181, 92),
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        SelectedFileView(context: context),
        SizedBox(height: 15),
        GojoBarButton(
          title: "Next",
          onClick: () {
            setState(() {
              currentStep = 3;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCheckAndConfirm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: ChooseProfilePic()),
        const SizedBox(height: 10),
        DataFilled(label: "First Name", value: "Kidus"),
        const SizedBox(height: 10),
        DataFilled(label: "Last Name", value: "Yoseph"),
        const SizedBox(height: 10),
        DataFilled(label: "Phone Number", value: "+251955211643"),
        const SizedBox(height: 10),
        SelectedFileView(context: context),
        const SizedBox(height: 10),
        CheckboxListTile(
          title: Text("I consent the details are valid"),
          value: true,
          onChanged: (newValue) {},
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const SizedBox(height: 10),
        GojoBarButton(
          title: "Confirm",
          onClick: () {
            Navigator.pushNamed(context, GojoRoutes.otp);
          },
        ),
      ],
    );
  }
}
