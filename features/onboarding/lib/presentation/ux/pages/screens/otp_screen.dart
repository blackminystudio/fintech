import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../util/constants/onboarding_constants.dart';
import '../../../store/onboarding_store_provider.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/onboarding_title.dart';
import '../../widgets/resend_otp.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({
    required this.correctOtp,
    required this.onTap,
    required this.onResendOtp,
    super.key,
  });
  final String correctOtp;
  final VoidCallback onTap;
  final VoidCallback onResendOtp;
  @override
  ConsumerState<OtpScreen> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpScreen> {
  late TextEditingController otpController;
  String? errorMessage;
  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

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
    final number =
        ref.read(onboardingStoreProvider).onboardingEntity?.mobileNumber;
    final subTitle = '${OnboardingConstants.otpSentText}$number.';
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.s32),
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
                SizedBox(height: theme.spacing.s16),
                ResendOtpWidget(
                  // TODO: resend is set to 5 for DEV only
                  countDown: 5,
                  onResend: widget.onResendOtp,
                ),
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
      autoDisposeControllers: false,
      controller: otpController,
      appContext: context,
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(theme.borderradius.normal),
        fieldHeight: theme.sizing.s13,
        fieldWidth: theme.sizing.s13,
        activeFillColor: theme.colors.neutralBorder,
        inactiveFillColor: theme.colors.neutralBorder,
        selectedFillColor: theme.colors.neutralBorder,
        activeColor:
            errorMessage.isNotNullOrEmpty
                ? theme.colors.accentRed
                : theme.colors.neutralBorder,
        inactiveColor: theme.colors.neutralBorder,
        selectedColor: theme.colors.neutralBorder,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
