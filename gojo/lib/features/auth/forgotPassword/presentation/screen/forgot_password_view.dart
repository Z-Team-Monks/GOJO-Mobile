import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/widgets/parent_view.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../signin/data_layer/repository/sign_in_repository.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  // final String phoneNumber;
  const ForgotPasswordView({
    super.key,
    // required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        phoneNumber: '0955211643',
        signInRepository: GetIt.I<SignInRepositoryAPI>(),
      ),
      child: GojoParentView(
        label: "Forgot Password",
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            switch (state.status) {
              case ForgotPasswordStatus.success:
                GojoSnackBars.showSuccess(
                    context, "Password reset succesfully");
                Navigator.of(context).pop();
                break;
              case ForgotPasswordStatus.error:
                GojoSnackBars.showError(context, "Something went wrong");
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.22),
                  GojoTextField(
                    labelText: AppLocalizations.of(context)!.password,
                    onChanged: (value) {
                      context
                          .read<ForgotPasswordBloc>()
                          .add(PasswordChanged(value));
                    },
                    errorText: state.passwordError,
                  ),
                  const SizedBox(height: 15),
                  GojoTextField(
                    labelText: "Confirm Password",
                    onChanged: (value) {
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ConfirmPasswordChanged(value));
                    },
                    errorText: state.confirmPasswordError,
                  ),
                  const SizedBox(height: 30),
                  GojoBarButton(
                      title: "Reset",
                      isActive: _isResetActive(state),
                      loadingState:
                          state.status == ForgotPasswordStatus.loading,
                      onClick: () {
                        context
                            .read<ForgotPasswordBloc>()
                            .add((ResetSubmitted()));
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isResetActive(ForgotPasswordState state) {
    return state.passwordError == null && state.confirmPasswordError == null;
  }
}
