import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../utilities/onboarding_constants.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/expandable_search.dart';
import '../../widgets/onboarding_title.dart';

class PersonalInfoScreen extends StatefulWidget {
  final List<String> cityList;
  final VoidCallback onTap;

  const PersonalInfoScreen({
    super.key,
    required this.onTap,
    required this.cityList,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoScreen>
    with WidgetsBindingObserver {
  TextEditingController cityController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _cityFocusNode = FocusNode();
  bool _keyboardVisible = false;

  String? selectedCity;
  String? selectedGender;
  String? selectedMaritalStatus;

  final genderOptions = [
    OnboardingConstants.male,
    OnboardingConstants.female,
    OnboardingConstants.other,
  ];

  final maritalOptions = [
    OnboardingConstants.married,
    OnboardingConstants.single,
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  bool get _isFormValid =>
      selectedCity != null &&
      selectedGender != null &&
      selectedMaritalStatus != null;

  void _onTapContinue() {
    widget.onTap.call();
    FocusScope.of(context).unfocus();
  }

  void _onSearchSelected(String? value) {
    setState(() {
      selectedCity = value;
    });
  }

  void _onSearchChanged(value) {
    setState(() {
      selectedCity = null;
    });
  }

  void _onSelectedMaritalStatus(String? value) {
    setState(() {
      selectedMaritalStatus = value;
    });
  }

  void _onSelectedGender(String? value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cityFocusNode.dispose();
    cityController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Used for keyboard visibility detection
  @override
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    final newKeyboardVisible = bottomInset > 0;

    if (newKeyboardVisible && !_keyboardVisible && _cityFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          // Height of the Header
          Theme.of(context).sizing.height.s28,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
    _keyboardVisible = newKeyboardVisible;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.height.s32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingTitle(
                  onboardingPageType: OnboardingPageType.small,
                  title: OnboardingConstants.personalInfoTitle,
                  subTitle: OnboardingConstants.personalInfoNote,
                ),
                Text(
                  OnboardingConstants.cityLabel,
                  style: theme.textStyle.headingXxsmall.copyWith(
                    color: theme.colors.textSecondarylight,
                  ),
                ),
                SizedBox(height: theme.sizing.height.s3),
                ExpandableSearchField(
                  allItems: widget.cityList,
                  focusNode: _cityFocusNode,
                  onSelected: _onSearchSelected,
                  onChanged: _onSearchChanged,
                ),
                SizedBox(height: theme.sizing.height.s10),
                ..._buildChipsSection(
                  theme,
                  label: OnboardingConstants.genderLabel,
                  options: genderOptions,
                  selectedValue: selectedGender,
                  onSelected: _onSelectedGender,
                ),
                SizedBox(height: theme.sizing.height.s10),
                ..._buildChipsSection(
                  theme,
                  options: maritalOptions,
                  label: OnboardingConstants.maritalStatusLabel,
                  selectedValue: selectedMaritalStatus,
                  onSelected: _onSelectedMaritalStatus,
                ),
                SizedBox(height: theme.sizing.height.s10),
              ],
            ),
          ),
        ),
        BottomActionBar(
          onTap: _isFormValid ? _onTapContinue : null,
          label: OnboardingConstants.continueButtonText,
        ),
      ],
    );
  }

  List<Widget> _buildChipsSection(
    ThemeData theme, {
    required String label,
    required List<String> options,
    required String? selectedValue,
    required ValueChanged<String?> onSelected,
  }) =>
      [
        Text(
          label,
          style: theme.textStyle.headingXxsmall.copyWith(
            color: theme.colors.textSecondarylight,
          ),
        ),
        SizedBox(height: theme.sizing.height.s4),
        Wrap(
          spacing: theme.spacing.width.s8,
          runSpacing: theme.spacing.height.s12,
          children: options
              .map(
                (option) => ChoiceChip(
                  label: Text(option),
                  selected: selectedValue == option,
                  onSelected: (isSelected) =>
                      onSelected(isSelected ? option : null),
                ),
              )
              .toList(),
        ),
      ];
}
