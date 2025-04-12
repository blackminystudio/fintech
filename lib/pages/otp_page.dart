import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/onboardpage_constants.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();
  int countdown = 30;
  bool isOtpIncorrect = false;
  String correctOtp = '788525';
  bool isResendAvailable = false;
  @override
  void initState() {
    super.initState();
    startCountdown();
    _setUpOtpListener();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void _setUpOtpListener() {
    otpController.addListener(() {
      if (isOtpIncorrect) {
        setState(() {
          isOtpIncorrect = false;
        });
      }
    });
  }

  Future<void> startCountdown() async {
    setState(() {
      isResendAvailable = false;
      countdown = 30;
    });

    while (countdown > 0) {
      setState(() {
        countdown--;
      });

      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() {
      isResendAvailable = true;
    });
  }

  void verifyOtp() {
    if (otpController.text == correctOtp) {
      setState(() {
        isOtpIncorrect = false;
      });
    } else {
      setState(() {
        isOtpIncorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.neutralLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: theme.sizing.height.s8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: theme.sizing.height.s5),
                    _buildProgressHeader(),
                    SizedBox(height: theme.sizing.height.s8),
                    Text(
                      OnboardpageConstants.otpHeading,
                      style: theme.textStyle.headingXxlarge.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: theme.sizing.height.s5),
                    Text(
                      OnboardpageConstants.otpSentText,
                      style: theme.textStyle.bodyMedium.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: theme.sizing.height.s8),
                    _buildPincodeField(context),
                    if (isOtpIncorrect)
                      Text(
                        OnboardpageConstants.otpError,
                        style: theme.textStyle.headingSmall.copyWith(
                          color: theme.colors.accentRed,
                        ),
                      ),
                    SizedBox(height: theme.sizing.height.s4),
                    _buildResendOtp(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Row _buildProgressHeader() {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.neutralBorder),
              borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
            ),
            child: Padding(
              padding: EdgeInsets.all(theme.sizing.height.s3),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: theme.sizing.height.s6,
                color: theme.colors.textPrimary,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text(
              OnboardpageConstants.progressText,
              style: theme.textStyle.headingSmall.copyWith(
                color: theme.colors.accentPurple,
              ),
            ),
            SizedBox(height: theme.sizing.height.s3),
            SizedBox(
              width: theme.sizing.width.s50,
              height: theme.spacing.height.s4,
              child: LinearProgressIndicator(
                value: 0.22,
                color: theme.colors.accentPurple,
                backgroundColor: theme.colors.neutralBorder,
                borderRadius: BorderRadius.circular(theme.borderradius.xSmall),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            OnboardpageConstants.skipText,
            style: theme.textStyle.headingSmall.copyWith(
              color: theme.colors.textPrimary,
            ),
          ),
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
        activeColor: isOtpIncorrect
            ? theme.colors.accentRed
            : theme.colors.neutralBorder,
        inactiveColor: theme.colors.neutralBorder,
        selectedColor: theme.colors.neutralBorder,
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  GestureDetector _buildResendOtp() {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: isResendAvailable ? startCountdown : null,
      child: Container(
        decoration: isResendAvailable
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: theme.spacing.height.s2,
                    color: theme.colors.accentPurple,
                  ),
                ),
              )
            : null,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: isResendAvailable
                    ? OnboardpageConstants.resendOtp
                    : OnboardpageConstants.resendIn,
                style: theme.textStyle.bodyMedium.copyWith(
                  color: isResendAvailable
                      ? theme.colors.accentPurple
                      : theme.colors.textSecondary,
                ),
              ),
              if (!isResendAvailable)
                TextSpan(
                  text: '${countdown}s',
                  style: theme.textStyle.bodyMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildBottomActionBar() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.neutralLightBackground,
        border: Border(
          top: BorderSide(
            color: theme.colors.neutralBorder,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: theme.sizing.height.s5,
        horizontal: theme.sizing.height.s8,
      ),
      child: MinyButton(
        label: OnboardpageConstants.verifyButtonText,
        onPressed: verifyOtp,
      ),
    );
  }
}
