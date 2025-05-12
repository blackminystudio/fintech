import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';
import '../widgets/resend_otp.dart';

class OtpPage extends StatefulWidget {
  final String correctOtp;
  final VoidCallback onTap;
  final VoidCallback onResendOtp;
  const OtpPage({
    super.key,
    required this.correctOtp,
    required this.onTap,
    required this.onResendOtp,
  });
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();
  String? errorMessage;
  bool isOtpIncorrect = false;
  void _onTapSubmit() {
    verifyOtp();
    widget.onTap();
  }

  void _handleOtpChange(String value) {
    if (value.length == 6 && isOtpIncorrect) {
      setState(() {
        isOtpIncorrect = false;
        errorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                const OnboardingTitle(
                  title: OnboardingConstants.otpHeading,
                  subTitle: OnboardingConstants.otpSentText,
                ),
                _buildPincodeField(context),
                if (isOtpIncorrect && errorMessage != null)
                  Text(
                    errorMessage!,
                    style: theme.textStyle.headingSmall.copyWith(
                      color: theme.colors.accentRed,
                    ),
                  ),
                SizedBox(height: theme.sizing.height.s4),
                ResendOtpWidget(
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

  void verifyOtp() {
    final enteredOtp = otpController.text.trim();

    if (enteredOtp.length < 6) {
      setState(() {
        isOtpIncorrect = true;
        errorMessage = OnboardingConstants.otpValidationError;
      });
      return;
    }

    if (enteredOtp == widget.correctOtp) {
      setState(() {
        isOtpIncorrect = false;
        errorMessage = null;
      });
    } else {
      setState(() {
        isOtpIncorrect = true;
        errorMessage = OnboardingConstants.otpError;
      });
    }
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
        activeColor: isOtpIncorrect
            ? theme.colors.accentRed
            : theme.colors.neutralBorder,
        inactiveColor: theme.colors.neutralBorder,
        selectedColor: theme.colors.neutralBorder,
      ),
      keyboardType: TextInputType.number,
      onChanged: _handleOtpChange,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }
}
