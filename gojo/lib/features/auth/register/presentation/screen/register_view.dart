import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GojoPadding.small),
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                controlsBuilder:
                    (BuildContext context, ControlsDetails controlsDetails) {
                  return Row(
                    children: [
                      ElevatedButton(
                        onPressed: _currentStep < 2
                            ? controlsDetails.onStepContinue
                            : () {
                                // TODO: Submit logic goes here
                              },
                        child: Text(
                          _currentStep < 2 ? "Next" : "Submit",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                steps: [
                  Step(
                    title: const Text('Personal Information'),
                    content: Column(
                      children: const <Widget>[
                        SizedBox(height: 15),
                        GojoTextField(labelText: "First Name"),
                        SizedBox(height: 15),
                        GojoTextField(labelText: "Last Name"),
                        SizedBox(height: 15),
                        GojoTextField(labelText: "Phone"),
                        SizedBox(height: 15),
                        GojoTextField(labelText: "Street"),
                        SizedBox(height: 15),
                        GojoTextField(labelText: "City"),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('ID Card'),
                    content: DashedRect(
                      color: Resources.gojoColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(60),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.upload_file_sharp,
                            size: 60,
                            color: Resources.gojoColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Payment Information'),
                    content: Column(
                      children: const <Widget>[
                        SizedBox(height: 15),
                        GojoTextField(labelText: "Bank Name"),
                        SizedBox(height: 15),
                        GojoTextField(labelText: "Holder Name"),
                        SizedBox(height: 15),
                        GojoTextField(labelText: "Account Number"),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
