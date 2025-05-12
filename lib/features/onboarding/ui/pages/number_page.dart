import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:miny_design_system/src/cards/miny_container.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';

class NumberPage extends StatefulWidget {
  final Function(String number) onTap;
  const NumberPage({
    super.key,
    required this.onTap,
  });

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isValid = true;
  int mobileNumberLength = 10;

  bool get isCurrentlyValid =>
      _mobileController.text.length == mobileNumberLength;

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(_handleMobileChange);
  }

  void _onTapVerify() {
    _validateMobileNumber();
    if (_isValid) {
      widget.onTap.call(_mobileController.text);
    }
  }

  void _handleMobileChange() {
    if (isCurrentlyValid) {
      FocusScope.of(context).unfocus();
      setState(() {
        _isValid = isCurrentlyValid;
      });
    }
  }

  void _validateMobileNumber() {
    setState(() {
      _isValid = isCurrentlyValid;
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
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
                  title: OnboardingConstants.enterMobileText,
                  subTitle: OnboardingConstants.otpSubText,
                ),
                _buildPhoneNumberField(),
                SizedBox(height: theme.spacing.height.s4),
                if (!_isValid)
                  Text(
                    OnboardingConstants.mobileValidationError,
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
          label: OnboardingConstants.verifyButtonText,
          onTap: _onTapVerify,
        ),
      ],
    );
  }

  Widget _buildPhoneNumberField() {
    final theme = Theme.of(context);
    return MinyContainer(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.width.s12,
      ),
      backgroundColor: theme.colors.neutralLight,
      borderSide: BorderSide(
        width: theme.spacing.width.s2,
        color: !_isValid ? theme.colors.accentRed : theme.colors.neutralBorder,
      ),
      borderRadius: theme.borderradius.normal,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              OnboardingConstants.countryCode,
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
              child: TextField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                style: theme.textStyle.headingLarge.copyWith(
                  color: theme.colors.textPrimary,
                ),
                scrollPadding: const EdgeInsets.all(0),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: theme.spacing.height.s20,
                  ),
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
          ],
        ),
      ),
    );
  }
}
