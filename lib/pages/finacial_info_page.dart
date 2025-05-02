import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';
import '../constants/onboardpage_constants.dart';
import 'widgets/bottom_action_bar.dart';
import 'widgets/onboarding_title.dart';
import 'widgets/progress_header.dart';

class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key});

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  TextEditingController cityController = TextEditingController();
  String? selectIncome;
  String? selectEmploymentStastus;
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            OnboardpageConstants.monthlyIncomeLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s4),
                          _buildMonthlyIncomeChips(theme),
                          SizedBox(height: theme.sizing.height.s10),
                          Text(
                            OnboardpageConstants.employmentStatusLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s4),
                          _buildEmploymentStatus(theme),
                          SizedBox(height: theme.sizing.height.s4),
                        ],
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

  Wrap _buildEmploymentStatus(ThemeData theme) => Wrap(
        spacing: theme.sizing.width.s3,
        runSpacing: theme.sizing.height.s3,
        children: [
          ChoiceChip(
            label: const Text(OnboardpageConstants.unemployed),
            selected:
                selectEmploymentStastus == OnboardpageConstants.unemployed,
            onSelected: (value) {
              setState(
                () {
                  selectEmploymentStastus =
                      value ? OnboardpageConstants.unemployed : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.student1,
            ),
            selected: selectEmploymentStastus == OnboardpageConstants.student1,
            onSelected: (value) {
              setState(
                () {
                  selectEmploymentStastus =
                      value ? OnboardpageConstants.student1 : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.privateJob,
            ),
            selected:
                selectEmploymentStastus == OnboardpageConstants.privateJob,
            onSelected: (value) {
              setState(
                () {
                  selectEmploymentStastus =
                      value ? OnboardpageConstants.privateJob : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.governmentJob,
            ),
            selected:
                selectEmploymentStastus == OnboardpageConstants.governmentJob,
            onSelected: (value) {
              setState(
                () {
                  selectEmploymentStastus =
                      value ? OnboardpageConstants.governmentJob : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.professional,
            ),
            selected:
                selectEmploymentStastus == OnboardpageConstants.professional,
            onSelected: (value) {
              setState(
                () {
                  selectEmploymentStastus =
                      value ? OnboardpageConstants.professional : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.retired,
            ),
            selected: selectEmploymentStastus == OnboardpageConstants.retired,
            onSelected: (value) {
              setState(
                () {
                  selectEmploymentStastus =
                      value ? OnboardpageConstants.retired : null;
                },
              );
            },
          ),
        ],
      );

  Wrap _buildMonthlyIncomeChips(ThemeData theme) => Wrap(
        spacing: theme.sizing.width.s3,
        runSpacing: theme.sizing.height.s3,
        children: [
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.income0to10k,
            ),
            selected: selectIncome == OnboardpageConstants.income0to10k,
            onSelected: (value) {
              setState(
                () {
                  selectIncome =
                      value ? OnboardpageConstants.income0to10k : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.income10kto50k,
            ),
            selected: selectIncome == OnboardpageConstants.income10kto50k,
            onSelected: (value) {
              setState(
                () {
                  selectIncome =
                      value ? OnboardpageConstants.income10kto50k : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.income50kto100k,
            ),
            selected: selectIncome == OnboardpageConstants.income50kto100k,
            onSelected: (value) {
              setState(
                () {
                  selectIncome =
                      value ? OnboardpageConstants.income50kto100k : null;
                },
              );
            },
          ),
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.income100kto500k_1,
            ),
            selected: selectIncome == OnboardpageConstants.income100kto500k_1,
            onSelected: (value) {
              setState(
                () {
                  selectIncome =
                      value ? OnboardpageConstants.income100kto500k_1 : null;
                },
              );
            },
          ),
          // multiple value present income100kto500k
          ChoiceChip(
            label: const Text(
              OnboardpageConstants.income100kto500k_2,
            ),
            selected: selectIncome == OnboardpageConstants.income100kto500k_2,
            onSelected: (value) {
              setState(
                () {
                  selectIncome =
                      value ? OnboardpageConstants.income100kto500k_2 : null;
                },
              );
            },
          ),
        ],
      );
}
