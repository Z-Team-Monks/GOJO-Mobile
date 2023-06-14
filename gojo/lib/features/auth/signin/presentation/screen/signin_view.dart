import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/design_tokens/padding.dart';
import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/app_icon.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/text_link.dart';
import '../../../../../Gojo-Mobile-Shared/core/repository/user_repository.dart';
import '../../../../../constants/strings/app_routes.dart';
import '../../data_layer/repository/sign_in_repository.dart';
import '../bloc/sign_in_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GojoParentView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GojoPadding.small,
        ),
        child: BlocProvider(
          create: (context) => SignInBloc(
            signInRepository: GetIt.I<SignInRepositoryAPI>(),
            userRepository: GetIt.I<UserRepositoryAPI>(),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _Header(),
                const _SignInForm(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.dontHaveAccount),
                    const SizedBox(width: 5),
                    TextLink(
                      label: AppLocalizations.of(context)!.register,
                      onClick: () {
                        Navigator.pushNamed(context, GojoRoutes.register);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80),
        GojoAppIcon(),
        SizedBox(height: 50),
        Text(
          AppLocalizations.of(context)!.welcomeToGojo,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.gojoMoto),
        SizedBox(height: 30),
      ],
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status == SignInRequestStatus.error) {
          GojoSnackBars.showError(context, state.errorMessage ?? "");
        }
        if (state.status == SignInRequestStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, GojoRoutes.root, (route) => false);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            GojoTextField(
              labelText: AppLocalizations.of(context)!.phoneNumber,
              textInputType: TextInputType.number,
              onChanged: (value) {
                context.read<SignInBloc>().add(PhoneNumberChanged(value));
              },
              errorText:
                  !state.phoneNumber.isPure && state.phoneNumber.isNotValid
                      ? state.phoneNumber.getErrorMessage()
                      : null,
            ),
            const SizedBox(height: 15),
            GojoTextField(
              labelText: AppLocalizations.of(context)!.password,
              isObscure: true,
              onChanged: (value) {
                context.read<SignInBloc>().add(PasswordChanged(value));
              },
              errorText: !state.password.isPure && state.password.isNotValid
                  ? state.password.getErrorMessage()
                  : null,
            ),
            const SizedBox(height: 30),
            GojoBarButton(
              title: AppLocalizations.of(context)!.logout,
              loadingState: state.status == SignInRequestStatus.loading,
              onClick: (() {
                if (state.password.isPure || state.phoneNumber.isPure) {
                  context
                      .read<SignInBloc>()
                      .add(PasswordChanged(state.password.value));
                  context
                      .read<SignInBloc>()
                      .add(PhoneNumberChanged(state.phoneNumber.value));
                } else {
                  context.read<SignInBloc>().add(Authenticate(
                      phoneNumber: state.phoneNumber.value,
                      password: state.password.value));
                }
              }),
            ),
          ],
        );
      },
    );
  }
}
