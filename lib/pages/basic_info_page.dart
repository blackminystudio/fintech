import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../constants/onboardpage_constants.dart';

class BasicInfoPage extends StatefulWidget {
  BasicInfoPage({super.key});

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  final TextEditingController fullNameController =
      TextEditingController(text: OnboardpageConstants.name);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: theme.sizing.height.s5),
                    _buildProgressHeader(),
                    SizedBox(height: theme.sizing.height.s8),
                    Text(
                      OnboardpageConstants.basicInfoTitle,
                      style: theme.textStyle.headingXxlarge.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: theme.sizing.height.s5),
                    Text(
                      OnboardpageConstants.basicInfoSubtitle,
                      style: theme.textStyle.bodyMedium.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: theme.sizing.height.s8),
                    _buildInfoContentCard(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

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
                    labelText: OnboardpageConstants.fullNameLabel,
                    icon: OnboardpageConstants.fullNameIcon,
                    controller: fullNameController),
                SizedBox(height: theme.sizing.height.s7),
                Divider(
                  thickness: theme.spacing.height.s2,
                  height: theme.spacing.height.s0,
                  color: theme.colors.neutralLightBackground,
                ),
                SizedBox(height: theme.sizing.height.s7),
                _buildUserInfoCard(
                  text: OnboardpageConstants.email,
                  icon: OnboardpageConstants.emailIcon,
                  labelText: OnboardpageConstants.emailLabel,
                ),
                SizedBox(height: theme.sizing.height.s7),
                Divider(
                  thickness: theme.spacing.height.s2,
                  height: theme.spacing.height.s0,
                  color: theme.colors.neutralLightBackground,
                ),
                SizedBox(height: theme.sizing.height.s7),
                _buildUserInfoCard(
                  text: OnboardpageConstants.phoneNumber,
                  labelText: OnboardpageConstants.phoneLabel,
                  icon: OnboardpageConstants.phoneIcon,
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                theme.borderradius.small,
              ),
              color: theme.colors.neutralLightBackground,
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

  Padding _buildInfoContent(ThemeData theme) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.sizing.width.s7,
          vertical: theme.sizing.width.s4,
        ),
        child: Row(
          children: [
            Icon(
              size: theme.sizing.height.s6,
              OnboardpageConstants.infoIcon,
              color: theme.colors.accentPurple,
            ),
            SizedBox(width: theme.sizing.width.s3),
            Flexible(
              child: Text(
                OnboardpageConstants.basicInfoFooterNote,
                style: theme.textStyle.bodyXxsmall.copyWith(
                  color: theme.colors.accentPurple,
                ),
              ),
            )
          ],
        ),
      );

  Row _buildProgressHeader() {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.neutralBorder),
              borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
            ),
            child: Padding(
              padding: EdgeInsets.all(theme.sizing.height.s3),
              child: Icon(
                size: theme.sizing.height.s6,
                color: theme.colors.textPrimary,
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Text(
              OnboardpageConstants.progressText,
              style: theme.textStyle.headingSmall.copyWith(
                color: theme.colors.accentPurple,
              ),
            ),
            SizedBox(height: theme.sizing.height.s3),
            SizedBox(
              width: theme.sizing.width.s50,
              height: theme.spacing.height.s4,
              child: LinearProgressIndicator(
                value: 0.22,
                color: theme.colors.accentPurple,
                backgroundColor: theme.colors.neutralBorder,
                borderRadius: BorderRadius.circular(theme.borderradius.xSmall),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            OnboardpageConstants.skipText,
            style: theme.textStyle.headingSmall.copyWith(
              color: theme.colors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildBottomActionBar() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.neutralLightBackground,
        border: Border(
          top: BorderSide(
            color: theme.colors.neutralBorder,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: theme.sizing.height.s5,
        horizontal: theme.sizing.height.s8,
      ),
      child: MinyButton(
        label: OnboardpageConstants.confirmButtonText,
        onPressed: () {},
      ),
    );
  }
}
