import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/expandable_search.dart';
import '../widgets/onboarding_title.dart';

class PersonalInfoPage extends StatefulWidget {
  final Function(String? gender, String? maritalStatus) onTap;

  const PersonalInfoPage({super.key, required this.onTap});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController cityController = TextEditingController();
  String? selectedCity;
  String? selectedGender;
  String? selectedMaritalStatus;

  final List<String> cityList = [
    'Bhubaneswar, Odisha',
    'BA, Odisha',
    'BB, Odisha',
    'BC, Odisha',
    'BA, Odisha',
    'BB, Odisha',
    'BC, Odisha',
    'BA, Odisha',
    'BB, Odisha',
    'BC, Odisha',
    'Cuttack',
    'Khordha',
    'Kolkata',
    'Chennai',
    'Hyderabad',
    'Pune',
  ];

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
    cityController.addListener(() {
      setState(() {});
    });
  }

  bool get isFormValid =>
      selectedCity != null &&
      selectedGender != null &&
      selectedMaritalStatus != null;

  void _onTapOkay() {
    widget.onTap.call(selectedGender, selectedMaritalStatus);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.height.s32),
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
                  allItems: cityList,
                  onSelected: (value) {
                    setState(() {
                      selectedCity = value;
                    });
                  },
                ),
                SizedBox(height: theme.sizing.height.s10),
                ..._buildChipsSection(
                  theme,
                  label: OnboardingConstants.genderLabel,
                  options: genderOptions,
                  selectedValue: selectedGender,
                  onSelected: (value) => setState(() => selectedGender = value),
                ),
                SizedBox(height: theme.sizing.height.s10),
                ..._buildChipsSection(
                  theme,
                  label: OnboardingConstants.maritalStatusLabel,
                  options: maritalOptions,
                  selectedValue: selectedMaritalStatus,
                  onSelected: (value) => setState(
                    () => selectedMaritalStatus = value,
                  ),
                ),
                SizedBox(height: theme.sizing.height.s10),
              ],
            ),
          ),
        ),
        BottomActionBar(
          onTap: isFormValid ? _onTapOkay : null,
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
