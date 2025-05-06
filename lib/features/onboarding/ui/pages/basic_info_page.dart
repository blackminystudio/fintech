import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';
import 'package:miny_design_system/packages/figma_squircle/src/smooth_border_radius.dart';
import 'package:miny_design_system/packages/figma_squircle/src/smooth_rectangle_border.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';
import '../widgets/progress_header.dart';

class BasicInfoPage extends StatefulWidget {
  BasicInfoPage({super.key});

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  final TextEditingController fullNameController = TextEditingController(
    text: OnboardingConstants.name,
  );

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
                        progressValue: 0.33,
                        onTapSkip: () {},
                        onTapBack: () {},
                      ),
                      const OnboardingTitle(
                        title: OnboardingConstants.basicInfoTitle,
                        subTitle: OnboardingConstants.basicInfoSubtitle,
                      ),
                      _buildInfoContentCard(),
                    ],
                  ),
                ),
              ),
            ),
            BottomActionBar(
              label: OnboardingConstants.confirmButtonText,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  Padding _buildInfoContent(ThemeData theme) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.sizing.width.s7,
          vertical: theme.sizing.width.s4,
        ),
        child: Row(
          children: [
            Icon(
              size: theme.sizing.height.s6,
              OnboardingConstants.infoIcon,
              color: theme.colors.accentPurple,
            ),
            SizedBox(width: theme.sizing.width.s3),
            Flexible(
              child: Text(
                OnboardingConstants.basicInfoFooterNote,
                style: theme.textStyle.bodyXxsmall.copyWith(
                  color: theme.colors.accentPurple,
                ),
              ),
            )
          ],
        ),
      );

  Widget _buildInfoContentCard() {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.borderradius.large),
        color: theme.colors.accentPurpleAlpha,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(theme.borderradius.large),
              color: theme.colors.neutralLight,
              border: Border.all(
                color: theme.colors.neutralBorder,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: theme.sizing.height.s7,
            ),
            child: Column(
              children: [
                _buildUserInfoCard(
                    isActive: true,
                    text: fullNameController.text,
                    labelText: OnboardingConstants.fullNameLabel,
                    icon: OnboardingConstants.fullNameIcon,
                    controller: fullNameController),
                SizedBox(height: theme.sizing.height.s7),
                Divider(
                  thickness: theme.spacing.height.s2,
                  height: theme.spacing.height.s0,
                  color: theme.colors.neutralLightBackground,
                ),
                SizedBox(height: theme.sizing.height.s7),
                _buildUserInfoCard(
                  text: OnboardingConstants.email,
                  icon: OnboardingConstants.emailIcon,
                  labelText: OnboardingConstants.emailLabel,
                ),
                SizedBox(height: theme.sizing.height.s7),
                Divider(
                  thickness: theme.spacing.height.s2,
                  height: theme.spacing.height.s0,
                  color: theme.colors.neutralLightBackground,
                ),
                SizedBox(height: theme.sizing.height.s7),
                _buildUserInfoCard(
                  text: OnboardingConstants.phoneNumber,
                  labelText: OnboardingConstants.phoneLabel,
                  icon: OnboardingConstants.phoneIcon,
                ),
              ],
            ),
          ),
          _buildInfoContent(theme),
        ],
      ),
    );
  }

  Padding _buildUserInfoCard({
    required String labelText,
    required IconData icon,
    required String text,
    bool isActive = false,
    TextEditingController? controller,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.sizing.height.s7,
      ),
      child: Row(
        children: [
          // TODO: DS: Add MinyContainer with figma squircle
          Container(
            decoration: ShapeDecoration(
              color: theme.colors.neutralLightBackground,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: theme.borderradius.small,
                  cornerSmoothing: 1,
                ),
              ),
            ),
            padding: EdgeInsets.all(theme.sizing.height.s3),
            child: Icon(
              icon,
              size: theme.sizing.height.s5,
            ),
          ),
          SizedBox(width: theme.sizing.width.s4),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelText,
                  style: theme.textStyle.headingXsmall.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                ),
                SizedBox(width: theme.sizing.width.s4),
                isActive
                    ? TextField(
                        controller: controller,
                        style: theme.textStyle.headingMedium.copyWith(
                          color: theme.colors.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : Text(
                        text,
                        style: theme.textStyle.headingMedium.copyWith(
                          color: isActive
                              ? theme.colors.textPrimary
                              : theme.colors.textSecondarylight,
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
