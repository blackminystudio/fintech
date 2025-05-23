import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';

class FinancialInfoPage extends StatefulWidget {
  final VoidCallback onTap;

  const FinancialInfoPage({super.key, required this.onTap});

  @override
  State<FinancialInfoPage> createState() => _FinancialInfoPageState();
}

class _FinancialInfoPageState extends State<FinancialInfoPage> {
  String? selectedIncome;
  String? selectedEmploymentStatus;
  bool get isSelectionComplete =>
      selectedIncome != null && selectedEmploymentStatus != null;
  void _onTapConfirm() {
    {
      widget.onTap.call();
    }
  }

  final incomeOptions = [
    OnboardingConstants.income0to10k,
    OnboardingConstants.income10kto50k,
    OnboardingConstants.income50kto100k,
    OnboardingConstants.income100kto500k,
  ];

  final employmentOptions = [
    OnboardingConstants.unemployed,
    OnboardingConstants.student1,
    OnboardingConstants.professional,
    OnboardingConstants.privateJob,
    OnboardingConstants.governmentJob,
    OnboardingConstants.retired,
  ];

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingTitle(
                    title: OnboardingConstants.financialInfoTitle,
                    subTitle: OnboardingConstants.financialNote,
                  ),
                  ..._buildChipsSection(
                    theme,
                    label: OnboardingConstants.monthlyIncomeLabel,
                    options: incomeOptions,
                    selectedValue: selectedIncome,
                    onSelected: (value) => setState(
                      () => selectedIncome = value,
                    ),
                  ),
                  SizedBox(height: theme.sizing.height.s10),
                  ..._buildChipsSection(
                    theme,
                    label: OnboardingConstants.employmentStatusLabel,
                    options: employmentOptions,
                    selectedValue: selectedEmploymentStatus,
                    onSelected: (value) => setState(
                      () => selectedEmploymentStatus = value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        BottomActionBar(
          label: OnboardingConstants.confirmButtonText,
          onTap: isSelectionComplete ? _onTapConfirm : null,
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
          spacing: theme.spacing.width.s12,
          runSpacing: theme.spacing.height.s12,
          children: options
              .map(
                (option) => ChoiceChip(
                  label: Text(option),
                  selected: selectedValue == option,
                  onSelected: (isSelected) {
                    onSelected(isSelected ? option : null);
                  },
                ),
              )
              .toList(),
        ),
      ];
}
