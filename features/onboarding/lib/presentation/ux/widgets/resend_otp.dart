import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../util/constants/onboarding_constants.dart';

class ResendOtpWidget extends StatefulWidget {
  const ResendOtpWidget({
    required this.onResend,
    super.key,
    this.countDown = 30,
  });
  final int countDown;
  final VoidCallback onResend;

  @override
  State<ResendOtpWidget> createState() => ResendOtpWidgetState();
}

class ResendOtpWidgetState extends State<ResendOtpWidget> {
  Timer? _timer;
  int _countdown = 0;
  bool isResendAvailable = false;

  @override
  void initState() {
    super.initState();
    _countdown = widget.countDown;
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() {
      _countdown = widget.countDown;
      isResendAvailable = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 1) {
        timer.cancel();
        setState(() {
          _countdown = 0;
          isResendAvailable = true;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void resetCountdown() {
    setState(() {
      isResendAvailable = false;
      _countdown = widget.countDown;
      _startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap:
          isResendAvailable
              ? () {
                widget.onResend.call();
                resetCountdown();
              }
              : null,
      child: Container(
        decoration:
            isResendAvailable
                ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: theme.sizing.half,
                      color: theme.colors.accentPurple,
                    ),
                  ),
                )
                : null,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    isResendAvailable
                        ? OnboardingConstants.resendOtp
                        : OnboardingConstants.resendIn,
                style: theme.textStyle.bodyMedium.copyWith(
                  color:
                      isResendAvailable
                          ? theme.colors.accentPurple
                          : theme.colors.textSecondary,
                ),
              ),
              if (!isResendAvailable)
                TextSpan(
                  text: '${_countdown}s',
                  style: theme.textStyle.bodyMedium,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
