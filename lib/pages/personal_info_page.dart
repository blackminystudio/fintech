import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';
import '../constants/onboardpage_constants.dart';
import 'widgets/bottom_action_bar.dart';
import 'widgets/onboarding_title.dart';
import 'widgets/progress_header.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController cityController = TextEditingController();
  String? selectedGender;
  String? selectedMaritalStatus;

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
                        progressValue: 0.44,
                        onTapSkip: () {},
                        onTapBack: () {},
                      ),
                      const OnboardingTitle(
                        onboardingPageType: OnboardingPageType.small,
                        title: OnboardpageConstants.personalInfoTitle,
                        subTitle: OnboardpageConstants.personalInfoNote,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            OnboardpageConstants.cityLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s3),
                          const MinyTextField(
                            hintText: OnboardpageConstants.enterCityText,
                          ),
                          SizedBox(height: theme.sizing.height.s10),
                          Text(
                            OnboardpageConstants.genderLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s3),
                          Wrap(
                            spacing: theme.spacing.width.s8,
                            runSpacing: theme.spacing.height.s12,
                            children: [
                              ChoiceChip(
                                label: const Text(OnboardpageConstants.male),
                                selected:
                                    selectedGender == OnboardpageConstants.male,
                                onSelected: (value) {
                                  setState(() {
                                    selectedGender = value
                                        ? OnboardpageConstants.male
                                        : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: const Text(OnboardpageConstants.female),
                                selected: selectedGender ==
                                    OnboardpageConstants.female,
                                onSelected: (value) {
                                  setState(() {
                                    selectedGender = value
                                        ? OnboardpageConstants.female
                                        : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: const Text(OnboardpageConstants.other),
                                selected: selectedGender ==
                                    OnboardpageConstants.other,
                                onSelected: (value) {
                                  setState(() {
                                    selectedGender = value
                                        ? OnboardpageConstants.other
                                        : null;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: theme.sizing.height.s10),
                          Text(
                            OnboardpageConstants.maritalStatusLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChoiceChip(
                                label: const Text(OnboardpageConstants.married),
                                selected: selectedMaritalStatus ==
                                    OnboardpageConstants.married,
                                onSelected: (value) {
                                  setState(() {
                                    selectedMaritalStatus = value
                                        ? OnboardpageConstants.married
                                        : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: const Text(OnboardpageConstants.single),
                                selected: selectedMaritalStatus ==
                                    OnboardpageConstants.single,
                                onSelected: (value) {
                                  setState(() {
                                    selectedMaritalStatus = value
                                        ? OnboardpageConstants.single
                                        : null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomActionBar(
              onPressed: () {},
              label: OnboardpageConstants.continueButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
