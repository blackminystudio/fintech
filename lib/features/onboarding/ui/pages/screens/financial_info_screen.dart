import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../store/onboarding_store.dart';
import '../../../utilities/onboarding_constants.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/onboarding_title.dart';

class FinancialInfoScreen extends ConsumerStatefulWidget {
  const FinancialInfoScreen({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  ConsumerState<FinancialInfoScreen> createState() => _FinancialInfoPageState();
}

class _FinancialInfoPageState extends ConsumerState<FinancialInfoScreen> {
  late UserProfileStore store;
  String? selectedIncome;
  String? selectedEmploymentStatus;
  bool get isSelectionComplete =>
      selectedIncome != null && selectedEmploymentStatus != null;

  @override
  void initState() {
    super.initState();
    store = ref.read(userProfileProvider.notifier);
    final info = ref.read(userProfileProvider).info;
    selectedIncome = info?.monthlyIncome;
    selectedEmploymentStatus = info?.employmentStatus;
  }

  void _onTapConfirm() {
    store.updateCopyUserInfo(
      monthlyIncome: selectedIncome,
      employmentStatus: selectedEmploymentStatus,
    );
    if (isSelectionComplete) {
      widget.onTap.call();
    }
  }

  void _onSelectIncome(String? value) {
    setState(() {
      selectedIncome = value;
    });
    store.updateCopyUserInfo(
      monthlyIncome: value,
    );
  }

  void _onSelectEmployeeStatus(String? value) {
    setState(() {
      selectedEmploymentStatus = value;
    });
    store.updateCopyUserInfo(
      employmentStatus: value,
    );
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
                    onSelected: _onSelectIncome,
                  ),
                  SizedBox(height: theme.sizing.height.s10),
                  ..._buildChipsSection(
                    theme,
                    label: OnboardingConstants.employmentStatusLabel,
                    options: employmentOptions,
                    selectedValue: selectedEmploymentStatus,
                    onSelected: _onSelectEmployeeStatus,
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
