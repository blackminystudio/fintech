import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../store/onboarding_store.dart';
import '../../../utilities/onboarding_constants.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/miny_divider.dart';
import '../../widgets/onboarding_title.dart';

class BasicInfoScreen extends ConsumerStatefulWidget {
  final VoidCallback onTap;

  const BasicInfoScreen({
    super.key,
    required this.onTap,
  });

  @override
  ConsumerState<BasicInfoScreen> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends ConsumerState<BasicInfoScreen> {
  String? _errorText;
  late UserProfileStore store;
  late TextEditingController fullNameController;

  void _onTapconfirm() {
    FocusScope.of(context).unfocus();
    final name = fullNameController.text.trim();
    setState(() {
      if (name.isEmpty) {
        _errorText = OnboardingConstants.nameEmpty;
      } else {
        store.updateName(name);
        widget.onTap.call();
        _errorText = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    store = ref.read(userProfileProvider.notifier);
    fullNameController = TextEditingController(
      text: ref.read(userProfileProvider).info?.fullName,
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

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
                SizedBox(height: theme.spacing.height.s40),
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

  Widget _buildInfoContentCard() {
    final theme = Theme.of(context);
    final user = ref.watch(userProfileProvider);
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
                  text: user.info?.fullName ?? '',
                  labelText: OnboardingConstants.fullNameLabel,
                  icon: OnboardingConstants.fullNameIcon,
                  controller: fullNameController,
                ),
                SizedBox(height: theme.sizing.height.s7),
                const MinyDivider(),
                SizedBox(height: theme.sizing.height.s7),
                _buildUserInfoCard(
                  text: user.auth?.email ?? '',
                  icon: OnboardingConstants.emailIcon,
                  labelText: OnboardingConstants.emailLabel,
                ),
                SizedBox(height: theme.sizing.height.s7),
                const MinyDivider(),
                SizedBox(height: theme.sizing.height.s7),
                _buildUserInfoCard(
                  text: user.info?.mobileNumber ?? '',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]'),
                          ),
                        ],
                        controller: controller,
                        style: theme.textStyle.headingMedium.copyWith(
                          color: theme.colors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          errorStyle: theme.textStyle.headingSmall.copyWith(
                            // TODO: DS: Add Token "WarningRed" (#EE4E4E);
                            color: theme.colors.accentRed,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          errorText: isActive ? _errorText : null,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
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
}
