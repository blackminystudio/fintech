import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';

class BasicInfoPage extends StatefulWidget {
  final Function(String name) onTap;

  const BasicInfoPage({super.key, required this.onTap});

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  String? _fullNameErrorText;
  void _onTapconfirm() {
    FocusScope.of(context).unfocus();

    setState(() {
      if (fullNameController.text.trim().isEmpty) {
        _fullNameErrorText = OnboardingConstants.nameEmpty;
      } else {
        widget.onTap.call(fullNameController.text);
        _fullNameErrorText = null;
      }
    });
  }

  final TextEditingController fullNameController = TextEditingController(
    text: OnboardingConstants.name,
  );

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingTitle(
                  title: OnboardingConstants.basicInfoTitle,
                  subTitle: OnboardingConstants.basicInfoSubtitle,
                ),
                _buildInfoContentCard(),
              ],
            ),
          ),
        ),
        BottomActionBar(
          label: OnboardingConstants.confirmButtonText,
          onTap: _onTapconfirm,
        ),
      ],
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
                  controller: fullNameController,
                ),
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
          MinyContainer(child: Icon(icon, size: theme.sizing.height.s5)),
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
                        decoration: InputDecoration(
                          errorStyle: theme.textStyle.headingSmall.copyWith(
                            // TODO: DS: Add Token "WarningRed" (#EE4E4E);
                            color: theme.colors.accentRed,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          errorText: isActive ? _fullNameErrorText : null,
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
