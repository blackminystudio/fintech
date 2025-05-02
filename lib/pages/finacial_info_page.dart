import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../constants/onboardpage_constants.dart';
import 'widgets/bottom_action_bar.dart';
import 'widgets/onboarding_title.dart';
import 'widgets/progress_header.dart';

class FinancialInfoPage extends StatefulWidget {
  const FinancialInfoPage({super.key});

  @override
  State<FinancialInfoPage> createState() => _FinancialInfoPageState();
}

class _FinancialInfoPageState extends State<FinancialInfoPage> {
  String? selectedIncome;
  String? selectedEmploymentStatus;

  final incomeOptions = [
    OnboardpageConstants.income0to10k,
    OnboardpageConstants.income10kto50k,
    OnboardpageConstants.income50kto100k,
    OnboardpageConstants.income100kto500k,
  ];

  final employmentOptions = [
    OnboardpageConstants.unemployed,
    OnboardpageConstants.student1,
    OnboardpageConstants.professional,
    OnboardpageConstants.privateJob,
    OnboardpageConstants.governmentJob,
    OnboardpageConstants.retired,
  ];

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProgressHeader(
                        progressValue: 0.11,
                        onTapSkip: () {},
                        onTapBack: () {},
                      ),
                      const OnboardingTitle(
                        title: OnboardpageConstants.financialInfoTitle,
                        subTitle: OnboardpageConstants.personalInfoNote,
                      ),
                      ..._buildChipsSection(
                        theme,
                        label: OnboardpageConstants.monthlyIncomeLabel,
                        options: incomeOptions,
                        selectedValue: selectedIncome,
                        onSelected: (value) => setState(
                          () => selectedIncome = value,
                        ),
                      ),
                      SizedBox(height: theme.sizing.height.s10),
                      ..._buildChipsSection(
                        theme,
                        label: OnboardpageConstants.employmentStatusLabel,
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
              label: OnboardpageConstants.confirmButtonText,
              onPressed: () {},
            ),
          ],
        ),
      ),
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
          spacing: theme.sizing.width.s3,
          runSpacing: theme.sizing.height.s3,
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
