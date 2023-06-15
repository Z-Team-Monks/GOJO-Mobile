import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gojo/Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import 'package:gojo/navigation/args/otp_args.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/parent_view.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/text_link.dart';
import '../../../../../Gojo-Mobile-Shared/resources/resources.dart';
import '../../../../../constants/strings/app_routes.dart';
import '../../../otp/presentation/bloc/otp_bloc.dart';
import '../../../register/data/repository/register_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OTPForgotPasswordView extends StatelessWidget {
  const OTPForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(
        registerRepository: GetIt.I<RegisterRepository>(),
      ),
      child: const _OTPView(),
    );
  }
}

class _OTPView extends StatelessWidget {
  const _OTPView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        switch (state.status) {
          case OtpStatus.inprogress:
            GojoSnackBars.showLoading(context, "Verifying OTP");
            break;
          case OtpStatus.sending:
            GojoSnackBars.showLoading(context, "Requesting Otp Code");
            break;
          case OtpStatus.codeSent:
            GojoSnackBars.showSuccess(context, "OTP Code Sent check your SMS");
            break;
          case OtpStatus.error:
            GojoSnackBars.showError(context, "Verifying OTP Failed");
            break;
          case OtpStatus.success:
            GojoSnackBars.showSuccess(context, "OTP Code Verified");
            Navigator.popAndPushNamed(
              context,
              GojoRoutes.resetPassword,
              arguments: OtpArgs(phone: state.phone.value),
            );
            break;
          default:
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GojoParentView(
          label: "Forgot Password",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Phone Verification",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return GojoTextField(
                      labelText: 'Phone',
                      hintText: 'Phone Number',
                      errorText: !state.phone.isPure && state.phone.isNotValid
                          ? state.phone.getErrorMessage()
                          : null,
                      onChanged: (value) {
                        BlocProvider.of<OtpBloc>(context).add(
                          SetPhone(phone: value),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return TextLink(
                      label: 'Get Code',
                      onClick: () {
                        if (state.phone.isPure || state.phone.isNotValid) {
                          BlocProvider.of<OtpBloc>(context).add(
                            SetPhone(phone: ''),
                          );
                          return;
                        }
                        BlocProvider.of<OtpBloc>(context).add(
                          ResendVerificationCode(),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                PinInputTextField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: BoxLooseDecoration(
                    radius: const Radius.circular(5),
                    gapSpace: 10,
                    strokeColorBuilder: FixedColorBuilder(
                      Resources.gojoColors.primaryColor,
                    ),
                  ),
                  pinLength: 6,
                  onChanged: (code) {
                    BlocProvider.of<OtpBloc>(context).add(
                      OTPCodeChanged(otp: code),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.noCodeReceived),
                    BlocBuilder<OtpBloc, OtpState>(
                      builder: (context, state) {
                        return TextLink(
                          label: AppLocalizations.of(context)!.resend,
                          onClick: () {
                            if (state.phone.isPure || state.phone.isNotValid) {
                              BlocProvider.of<OtpBloc>(context).add(
                                SetPhone(phone: ''),
                              );
                              return;
                            }
                            BlocProvider.of<OtpBloc>(context).add(
                              ResendVerificationCode(),
                            );
                            BlocProvider.of<OtpBloc>(context).add(
                              ResendVerificationCode(),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return GojoBarButton(
                      title: AppLocalizations.of(context)!.verify,
                      loadingState: state.status == OtpStatus.inprogress,
                      onClick: (state.otpCode.length == 6)
                          ? () {
                              BlocProvider.of<OtpBloc>(context).add(
                                VerifcationSubmitted(),
                              );
                            }
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
