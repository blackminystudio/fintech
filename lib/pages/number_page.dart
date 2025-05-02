import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:miny_design_system/packages/figma_squircle/src/smooth_border_radius.dart';
import 'package:miny_design_system/packages/figma_squircle/src/smooth_rectangle_border.dart';

import '../constants/onboardpage_constants.dart';
import 'widgets/bottom_action_bar.dart';
import 'widgets/onboarding_title.dart';
import 'widgets/progress_header.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isValid = true;
  bool _isSubmitted = false;
  int mobileNumberLength = 10;

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
                padding: EdgeInsets.symmetric(
                  horizontal: theme.sizing.height.s8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressHeader(
                      progressValue: 0.11,
                      onTapSkip: () {},
                      onTapBack: () {},
                    ),
                    const OnboardingTitle(
                      title: OnboardpageConstants.enterMobileText,
                      subTitle: OnboardpageConstants.otpSubText,
                    ),
                    _buildPhoneNumberField(),
                    SizedBox(height: theme.spacing.height.s4),
                    if (_isSubmitted && !_isValid)
                      Text(
                        OnboardpageConstants.mobileValidationError,
                        style: theme.textStyle.headingSmall.copyWith(
                          // TODO: DS: Add Token "WarningRed" (#EE4E4E);
                          color: theme.colors.accentRed,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            BottomActionBar(
              label: OnboardpageConstants.verifyButtonText,
              onPressed: _validateMobileNumber,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(_handleMobileChange);
  }

  Container _buildPhoneNumberField() {
    final theme = Theme.of(context);
    // TODO: DS: Add MinyContainer with figma squircle
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.sizing.width.s3,
      ),
      decoration: ShapeDecoration(
        shape: SmoothRectangleBorder(
          side: BorderSide(
            width: theme.spacing.width.s2,
            color: _isSubmitted && !_isValid
                ? theme.colors.accentRed
                : theme.colors.neutralBorder,
          ),
          borderRadius: SmoothBorderRadius(
            cornerRadius: theme.borderradius.normal,
            cornerSmoothing: 1,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              OnboardpageConstants.countryCode,
              style: theme.textStyle.bodyMedium.copyWith(
                color: theme.colors.textSecondarylight,
              ),
            ),
            SizedBox(width: theme.sizing.height.s3),
            Container(
              width: theme.spacing.width.s2,
              color: theme.colors.neutralBorder,
            ),
            SizedBox(width: theme.sizing.height.s3),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: theme.sizing.height.s5),
                child: TextField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  style: theme.textStyle.headingLarge.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                  scrollPadding: const EdgeInsets.all(0),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleMobileChange() {
    if (_isSubmitted) {
      setState(() {
        _isSubmitted = false;
      });
    }

    final isCurrentlyValid =
        _mobileController.text.length == mobileNumberLength;
    if (_isValid != isCurrentlyValid) {
      setState(() => _isValid = isCurrentlyValid);
    }
  }

  void _validateMobileNumber() {
    setState(() {
      _isSubmitted = true;
      _isValid = _mobileController.text.length == mobileNumberLength;
    });
  }
}
