import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';
import '../widgets/progress_header.dart';

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
                        title: OnboardingConstants.personalInfoTitle,
                        subTitle: OnboardingConstants.personalInfoNote,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            OnboardingConstants.cityLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s3),
                          const MinyTextField(
                            hintText: OnboardingConstants.enterCityText,
                          ),
                          SizedBox(height: theme.sizing.height.s10),
                          Text(
                            OnboardingConstants.genderLabel,
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
                                label: const Text(OnboardingConstants.male),
                                selected:
                                    selectedGender == OnboardingConstants.male,
                                onSelected: (value) {
                                  setState(() {
                                    selectedGender =
                                        value ? OnboardingConstants.male : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: const Text(OnboardingConstants.female),
                                selected: selectedGender ==
                                    OnboardingConstants.female,
                                onSelected: (value) {
                                  setState(() {
                                    selectedGender = value
                                        ? OnboardingConstants.female
                                        : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: const Text(OnboardingConstants.other),
                                selected:
                                    selectedGender == OnboardingConstants.other,
                                onSelected: (value) {
                                  setState(() {
                                    selectedGender = value
                                        ? OnboardingConstants.other
                                        : null;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: theme.sizing.height.s10),
                          Text(
                            OnboardingConstants.maritalStatusLabel,
                            style: theme.textStyle.headingXxsmall.copyWith(
                              color: theme.colors.textSecondarylight,
                            ),
                          ),
                          SizedBox(height: theme.sizing.height.s3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChoiceChip(
                                label: const Text(OnboardingConstants.married),
                                selected: selectedMaritalStatus ==
                                    OnboardingConstants.married,
                                onSelected: (value) {
                                  setState(() {
                                    selectedMaritalStatus = value
                                        ? OnboardingConstants.married
                                        : null;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: const Text(OnboardingConstants.single),
                                selected: selectedMaritalStatus ==
                                    OnboardingConstants.single,
                                onSelected: (value) {
                                  setState(() {
                                    selectedMaritalStatus = value
                                        ? OnboardingConstants.single
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
              label: OnboardingConstants.continueButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
