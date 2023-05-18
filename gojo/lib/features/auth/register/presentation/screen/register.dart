import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                          child: _buildRow(
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
                        _buildLine(true),
                        InkWell(
                          child: _buildRow(
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
                        _buildLine(true),
                        InkWell(
                          child: _buildRow(
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
                        _buildLine(true),
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
        _buildSelectedFileView(context),
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

  Container _buildSelectedFileView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFD5D5D5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.photo_library,
              color: Color.fromARGB(150, 27, 181, 92),
            ),
            Text(
              "No Selected File",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckAndConfirm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildProfilePic()),
        SizedBox(height: 10),
        _buildDataFilled(
          context,
          label: "First Name",
          value: "Kidus",
        ),
        SizedBox(height: 10),
        _buildDataFilled(
          context,
          label: "Last Name",
          value: "Yoseph",
        ),
        SizedBox(height: 10),
        _buildDataFilled(
          context,
          label: "Phone Number",
          value: "+251955211643",
        ),
        SizedBox(height: 10),
        _buildSelectedFileView(context),
        SizedBox(height: 10),
        CheckboxListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("I consent the details are valid"),
          value: true,
          onChanged: (newValue) {},
          controlAffinity: ListTileControlAffinity.leading,
        ),
        SizedBox(height: 10),
        GojoBarButton(
          title: "Confirm",
          onClick: () {
            Navigator.pushNamed(context, GojoRoutes.otp);
          },
        ),
      ],
    );
  }

  CircleAvatar _buildProfilePic() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: Image.asset(Resources.gojoImages.headShot).image,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.add_circle,
            color: Resources.gojoColors.primaryColor,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  Column _buildDataFilled(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Resources.gojoColors.primaryColor,
          ),
        ),
        Text(
          value,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildLine(bool visible) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Container(
        width: visible ? 1.0 : 0.0,
        height: 16.0,
        color: const Color.fromARGB(90, 255, 255, 255),
      ),
    );
  }

  Widget _buildRow({
    required int step,
    required String title,
    required bool isSelected,
  }) {
    return Row(
      children: [
        CircleAvatar(
          maxRadius: 15,
          backgroundColor: isSelected
              ? Colors.white
              : const Color.fromARGB(90, 255, 255, 255),
          foregroundColor: isSelected ? Colors.black : Colors.white,
          child: Text("$step"),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
