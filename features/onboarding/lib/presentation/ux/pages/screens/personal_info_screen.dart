import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../util/constants/onboarding_constants.dart';
import '../../../store/onboarding_store_provider.dart';
import '../../../store/src/onboarding_store.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/expandable_search.dart';
import '../../widgets/onboarding_title.dart';

class PersonalInfoScreen extends ConsumerStatefulWidget {
  const PersonalInfoScreen({
    required this.onTap,
    required this.cityList,
    super.key,
  });
  final List<String> cityList;
  final VoidCallback onTap;

  @override
  ConsumerState<PersonalInfoScreen> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends ConsumerState<PersonalInfoScreen>
    with WidgetsBindingObserver {
  late TextEditingController _cityController;
  late ScrollController _scrollController;
  final FocusNode _cityFocusNode = FocusNode();
  bool _keyboardVisible = false;
  late OnboardingStore store;
  String? selectedCity;
  String? selectedGender;
  String? selectedMaritalStatus;

  bool get _isFormValid =>
      selectedCity != null &&
      selectedGender != null &&
      selectedMaritalStatus != null;

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
    _cityController = TextEditingController();
    _scrollController = ScrollController();
    // Add WidgetsBinding observer to handle layout updates,
    // especially for city selector focus and height adjustments.
    WidgetsBinding.instance.addObserver(this);

    // Store Initialisation
    final info = ref.read(onboardingStoreProvider).onboardingEntity;
    store = ref.read(onboardingStoreProvider.notifier);
    selectedCity = info?.city;
    selectedGender = info?.gender;
    selectedMaritalStatus = info?.maritalStatus;

    if (selectedCity != null) {
      _cityController.text = selectedCity!;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cityFocusNode.dispose();
    _cityController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onTapContinue() {
    store.updateCopyUserInfo(
      city: selectedCity,
      gender: selectedGender,
      maritalStatus: selectedMaritalStatus,
    );
    FocusScope.of(context).unfocus();
    widget.onTap.call();
  }

  void _onSearchSelected(String? value) {
    setState(() {
      selectedCity = value;
    });
    store.updateCopyUserInfo(city: value);
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
    store.updateCopyUserInfo(maritalStatus: selectedMaritalStatus);
  }

  void _onSelectedGender(String? value) {
    setState(() {
      selectedGender = value;
    });
    store.updateCopyUserInfo(gender: value);
  }

  @override
  // Used for keyboard visibility detection
  void didChangeMetrics() {
    final bottomInset = View.of(context).viewInsets.bottom;
    final newKeyboardVisible = bottomInset > 0;

    if (newKeyboardVisible && !_keyboardVisible && _cityFocusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          // Height of the Header
          Theme.of(context).sizing.s28,
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
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.s32),
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
                SizedBox(height: theme.spacing.s12),
                ExpandableSearchField(
                  controller: _cityController,
                  allItems: widget.cityList,
                  focusNode: _cityFocusNode,
                  onSelected: _onSearchSelected,
                  onChanged: _onSearchChanged,
                ),
                SizedBox(height: theme.spacing.s40),
                ..._buildChipsSection(
                  theme,
                  label: OnboardingConstants.genderLabel,
                  options: genderOptions,
                  selectedValue: selectedGender,
                  onSelected: _onSelectedGender,
                ),
                SizedBox(height: theme.spacing.s40),
                ..._buildChipsSection(
                  theme,
                  options: maritalOptions,
                  label: OnboardingConstants.maritalStatusLabel,
                  selectedValue: selectedMaritalStatus,
                  onSelected: _onSelectedMaritalStatus,
                ),
                SizedBox(height: theme.spacing.s40),
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
  }) => [
    Text(
      label,
      style: theme.textStyle.headingXxsmall.copyWith(
        color: theme.colors.textSecondarylight,
      ),
    ),
    SizedBox(height: theme.spacing.s16),
    Wrap(
      spacing: theme.spacing.s8,
      runSpacing: theme.spacing.s12,
      children:
          options
              .map(
                (option) => ChoiceChip(
                  label: Text(option),
                  selected: selectedValue == option,
                  onSelected:
                      (isSelected) => onSelected(isSelected ? option : null),
                ),
              )
              .toList(),
    ),
  ];
}
