import 'dart:io';

import 'package:dashed_rect/dashed_rect.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';
import '../../../../../navigation/args/otp_args.dart';
import '../../data/repository/register_repository.dart';
import '../bloc/register_bloc.dart';
import 'widgets/choose_profile.dart';
import 'widgets/data_filled.dart';
import 'widgets/label_row.dart';
import 'widgets/selected_file.dart';
import 'widgets/vertical_line.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        registerRepository: GetIt.I<RegisterRepository>(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.formStatus == RegisterFormStatus.error) {
          GojoSnackBars.showError(context, "User Registration Failed!");
        } else if (state.formStatus == RegisterFormStatus.success) {
          Navigator.pushNamed(
            context,
            GojoRoutes.otp,
            arguments: OtpArgs(
              phone: state.phone.value,
            ),
          );
        }
      },
      child: GojoParentView(
        hasAppBar: false,
        isFullScreen: true,
        child: Container(
          color: Resources.gojoColors.primaryColor,
          child: Stack(
            children: [
              Column(
                children: [
                  _buildStepperHeader(),
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      maxRadius: 15,
                      backgroundColor: Colors.white,
                      foregroundColor: Resources.gojoColors.primaryColor,
                      child: const Text(
                        "X",
                        style: TextStyle(fontWeight: FontWeight.bold),
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

  Flexible _buildStepperHeader() {
    return Flexible(
      flex: 3,
      child: Row(
        children: [
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(child: SizedBox(height: 15)),
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
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: state.isPersonalInfoFormValid
                        ? _handleIdCardSelected
                        : null,
                    child: LabelRow(
                      step: 2,
                      title: "ID Card",
                      isSelected: currentStep == 2,
                    ),
                  );
                },
              ),
              const VerticalLine(visible: true),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: state.isIdCardSelected
                        ? _handleCheckAndConfirmSelected
                        : null,
                    child: LabelRow(
                      step: 3,
                      title: "Check and Confirm",
                      isSelected: currentStep == 3,
                    ),
                  );
                },
              ),
              const VerticalLine(visible: true),
            ],
          ),
        ],
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
        const SizedBox(height: 15),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoTextField(
              labelText: "First Name",
              initialValue: state.fname.value,
              errorText: !state.fname.isPure && state.fname.isNotValid
                  ? state.fname.getErrorMessage()
                  : null,
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context).add(
                  FirstNameChanged(fname: value),
                );
              },
            );
          },
        ),
        const SizedBox(height: 18),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoTextField(
              labelText: "Last Name",
              initialValue: state.lname.value,
              errorText: !state.lname.isPure && state.lname.isNotValid
                  ? state.lname.getErrorMessage()
                  : null,
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context).add(
                  LastNameChanged(lname: value),
                );
              },
            );
          },
        ),
        const SizedBox(height: 18),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoTextField(
              labelText: "Phone",
              initialValue: state.phone.value,
              errorText: !state.phone.isPure && state.phone.isNotValid
                  ? state.phone.getErrorMessage()
                  : null,
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context).add(
                  PhoneChanged(phone: value),
                );
              },
            );
          },
        ),
        const SizedBox(height: 18),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoTextField(
              labelText: "Password",
              initialValue: state.password.value,
              errorText: !state.password.isPure && state.password.isNotValid
                  ? state.password.getErrorMessage()
                  : null,
              isObscure: true,
              onChanged: (value) {
                BlocProvider.of<RegisterBloc>(context).add(
                  PasswordChanged(password: value),
                );
              },
            );
          },
        ),
        const SizedBox(height: 30),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoBarButton(
              title: "Next",
              onClick: state.isPersonalInfoFormValid
                  ? () {
                      _handleIdCardSelected();
                    }
                  : null,
            );
          },
        ),
      ],
    );
  }

  void _handleIdCardSelected() {
    setState(() {
      currentStep = 2;
    });
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
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state.idPath != null) {
              return SizedBox(
                height: 250,
                child: Image.file(
                  File(state.idPath!),
                ),
              );
            }
            return DashedRect(
              gap: 15,
              strokeWidth: 4,
              color: const Color.fromARGB(150, 27, 181, 92),
              child: Container(
                padding: const EdgeInsets.all(60),
                width: double.infinity,
                child: const Icon(
                  Icons.cloud_upload,
                  size: 70,
                  color: Color.fromARGB(150, 27, 181, 92),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 25),
        InkWell(
          child: const PickAFileButton(),
          onTap: () async {
            final path = await _getFile();
            if (mounted && path != null) {
              BlocProvider.of<RegisterBloc>(context).add(
                IDFileChanged(path: path),
              );
            }
          },
        ),
        const SizedBox(height: 15),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoBarButton(
              title: "Next",
              onClick: state.isIdCardSelected
                  ? _handleCheckAndConfirmSelected
                  : null,
            );
          },
        ),
      ],
    );
  }

  void _handleCheckAndConfirmSelected() {
    setState(() {
      currentStep = 3;
    });
  }

  Widget _buildCheckAndConfirm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: InkWell(
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return ChooseProfilePic(path: state.avatar);
              },
            ),
            onTap: () async {
              final path = await _getFile();
              if (mounted && path != null) {
                BlocProvider.of<RegisterBloc>(context).add(
                  AvatarChanged(path: path),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return DataFilled(
              label: "First Name",
              value: state.fname.value,
            );
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return DataFilled(
              label: "Last Name",
              value: state.lname.value,
            );
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return DataFilled(
              label: "Phone Number",
              value: state.phone.value,
            );
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return PickAFileButton(path: state.idPath);
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return CheckboxListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const Text("I consent the details are valid"),
              value: state.consentConfirmed,
              onChanged: (newValue) {
                BlocProvider.of<RegisterBloc>(context).add(
                  ConsentChanged(),
                );
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        ),
        const SizedBox(height: 5),
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return GojoBarButton(
              title: "Confirm",
              loadingState: state.formStatus == RegisterFormStatus.inprogress,
              onClick: state.isRegisterFormValid
                  ? () {
                      BlocProvider.of<RegisterBloc>(context).add(
                        ConfirmedAndSubmitted(),
                      );
                    }
                  : null,
            );
          },
        ),
      ],
    );
  }

  Future<String?> _getFile() async {
    try {
      var paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        onFileLoading: (FilePickerStatus status) =>
            debugPrint(status.toString()),
        dialogTitle: "Pick Your ID",
        lockParentWindow: true,
      ));
      return paths?.files.single.path;
    } catch (e) {
      return null;
    }
  }
}
