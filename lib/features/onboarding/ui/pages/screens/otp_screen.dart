import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/utilities/extenstions.dart';
import '../../../store/onboarding_store.dart';
import '../../../utilities/onboarding_constants.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/onboarding_title.dart';
import '../../widgets/resend_otp.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String correctOtp;
  final VoidCallback onTap;
  final VoidCallback onResendOtp;
  const OtpScreen({
    super.key,
    required this.correctOtp,
    required this.onTap,
    required this.onResendOtp,
  });
  @override
  ConsumerState<OtpScreen> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  String? errorMessage;

  void _onTapSubmit() {
    if (verifyOtp()) {
      widget.onTap();
    }
  }

  bool verifyOtp() {
    final enteredOtp = otpController.text;
    setState(() {
      if (enteredOtp.length < 6) {
        errorMessage = OnboardingConstants.otpValidationError;
      } else if (enteredOtp != widget.correctOtp) {
        errorMessage = OnboardingConstants.otpError;
      } else {
        errorMessage = null;
      }
    });
    return errorMessage == null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final number = ref.watch(userProfileProvider).info?.mobileNumber;
    final subTitle = '${OnboardingConstants.otpSentText}$number.';
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.height.s32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OnboardingTitle(
                  title: OnboardingConstants.otpHeading,
                  subTitle: subTitle,
                ),
                _buildPincodeField(context),
                if (errorMessage.isNotNullOrEmpty)
                  Text(
                    errorMessage!,
                    style: theme.textStyle.headingSmall.copyWith(
                      color: theme.colors.accentRed,
                    ),
                  ),
                SizedBox(height: theme.sizing.height.s4),
                ResendOtpWidget(
                  // TODO: resend is set to 5 for DEV only
                  countDown: 5,
                  onResend: widget.onResendOtp,
                )
              ],
            ),
          ),
        ),
        BottomActionBar(
          label: OnboardingConstants.submitOtp,
          onTap: _onTapSubmit,
        ),
      ],
    );
  }

  PinCodeTextField _buildPincodeField(BuildContext context) {
    final theme = Theme.of(context);
    return PinCodeTextField(
      controller: otpController,
      appContext: context,
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(theme.sizing.height.s3),
        fieldHeight: theme.sizing.height.s13,
        fieldWidth: theme.sizing.height.s13,
        activeFillColor: theme.colors.neutralBorder,
        inactiveFillColor: theme.colors.neutralBorder,
        selectedFillColor: theme.colors.neutralBorder,
        activeColor: errorMessage.isNotNullOrEmpty
            ? theme.colors.accentRed
            : theme.colors.neutralBorder,
        inactiveColor: theme.colors.neutralBorder,
        selectedColor: theme.colors.neutralBorder,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
