import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../constants/onboardpage_constants.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  @override
  void initState() {
    super.initState();

    _mobileController.addListener(_handleMobileChange);
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

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  final TextEditingController _mobileController = TextEditingController();
  bool _isValid = true;
  bool _isSubmitted = false;
  int mobileNumberLength = 10;

  void _validateMobileNumber() {
    setState(() {
      _isSubmitted = true;
      _isValid = _mobileController.text.length == mobileNumberLength;
    });
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
                      OnboardpageConstants.enterMobileText,
                      style: theme.textStyle.headingXxlarge.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: theme.sizing.height.s5),
                    Text(
                      OnboardpageConstants.otpSubText,
                      style: theme.textStyle.bodyMedium.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: theme.sizing.height.s8),
                    _buildPhoneNumberField(),
                    SizedBox(height: theme.spacing.height.s4),
                    // TODO: Need warning red (#EE4E4E);
                    if (_isSubmitted && !_isValid)
                      Text(
                        OnboardpageConstants.mobileValidationError,
                        style: theme.textStyle.headingSmall.copyWith(
                          color: theme.colors.accentRed,
                        ),
                      ),
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
        onPressed: _validateMobileNumber,
      ),
    );
  }

  Container _buildPhoneNumberField() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: theme.sizing.width.s3,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: theme.spacing.width.s2,
          color: _isSubmitted && !_isValid
              ? theme.colors.accentRed
              : theme.colors.neutralBorder,
        ),
        borderRadius: BorderRadius.circular(theme.borderradius.normal),
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
              width: theme.spacing.width.s1,
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
                  decoration: const InputDecoration(
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
                size: theme.sizing.height.s6,
                color: theme.colors.textPrimary,
                Icons.arrow_back_ios_new,
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
}
