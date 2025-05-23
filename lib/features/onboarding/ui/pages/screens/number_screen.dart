import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../store/onboarding_store.dart';
import '../../../utilities/onboarding_constants.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/onboarding_title.dart';

// | QA Scenario
// | ------------------------------------------------
// | User types <10 digits
// | User taps "Verify" with <10 digits
// | User types 10 digits and taps "Verify"
// | User deletes back to <10 after successful verify
// | User taps "Verify" again with <10 digits
// | User corrects to 10 digits after error

class NumberScreen extends ConsumerStatefulWidget {
  final VoidCallback onTap;
  const NumberScreen({
    super.key,
    required this.onTap,
  });

  @override
  ConsumerState<NumberScreen> createState() => _NumberPageState();
}

class _NumberPageState extends ConsumerState<NumberScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool _showError = false;
  bool get _isValidNow => _mobileController.text.length == 10;
  late UserProfileStore store;

  @override
  void initState() {
    super.initState();
    store = ref.read(userProfileProvider.notifier);
    final mobile = ref.read(userProfileProvider).info?.mobileNumber;
    if (mobile != null) {
      _mobileController.text = mobile;
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  void _onTapVerify() {
    setState(() {
      _showError = !_isValidNow;
    });
    if (_isValidNow) {
      widget.onTap.call();
      store.updateMobileNumber(_mobileController.text);
    }
  }

  void _handleTextChange(String value) {
    if (_isValidNow) {
      if (_showError) {
        setState(() {
          _showError = false;
        });
      }
      // Outside of setstate to avoid rebuild
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(userProfileProvider);
    final currentValue = user.info?.mobileNumber;
    if (currentValue != null && _mobileController.text != currentValue) {
      _mobileController
        ..text = currentValue
        ..selection = TextSelection.collapsed(offset: currentValue.length);
    }
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
                ..._buildErrorText()
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

  List<Widget> _buildErrorText() {
    if (!_showError) return [const SizedBox.shrink()];
    final theme = Theme.of(context);
    return [
      SizedBox(height: theme.spacing.height.s12),
      Text(
        OnboardingConstants.mobileValidationError,
        style: theme.textStyle.headingSmall.copyWith(
          // TODO: DS: Add Token "WarningRed" (#EE4E4E);
          color: theme.colors.accentRed,
        ),
      )
    ];
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
        color: _showError ? theme.colors.accentRed : theme.colors.neutralBorder,
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
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: theme.spacing.height.s20,
                  ),
                  isCollapsed: true,
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: _handleTextChange,
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
