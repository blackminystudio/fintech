import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../util/constants/onboarding_constants.dart';
import '../../../store/onboarding_store_provider.dart';
import '../../../store/src/onboarding_store.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/miny_divider.dart';
import '../../widgets/onboarding_title.dart';

class BasicInfoScreen extends ConsumerStatefulWidget {
  const BasicInfoScreen({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  ConsumerState<BasicInfoScreen> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends ConsumerState<BasicInfoScreen> {
  String? _errorText;
  late OnboardingStore store;
  late TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.s32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingTitle(
                  title: OnboardingConstants.basicInfoTitle,
                  subTitle: OnboardingConstants.basicInfoSubtitle,
                ),
                _buildInfoContentCard(),
                SizedBox(height: theme.spacing.s40),
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
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    store = ref.read(onboardingStoreProvider.notifier);
    _nameController = TextEditingController(
      text: ref.read(onboardingStoreProvider).entity?.fullName,
    );
  }

  Padding _buildInfoContent(ThemeData theme) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: theme.sizing.s7,
      vertical: theme.spacing.s16,
    ),
    child: Row(
      children: [
        Icon(
          size: theme.sizing.s6,
          OnboardingConstants.infoIcon,
          color: theme.colors.accentPurple,
        ),
        SizedBox(width: theme.spacing.s12),
        Flexible(
          child: Text(
            OnboardingConstants.basicInfoFooterNote,
            style: theme.textStyle.bodyXxsmall.copyWith(
              color: theme.colors.accentPurple,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildInfoContentCard() {
    final theme = Theme.of(context);
    final user = ref.watch(onboardingStoreProvider);
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
              border: Border.all(color: theme.colors.neutralBorder),
            ),
            padding: EdgeInsets.symmetric(
              //TODO:DS Add size-s7  &&  space-s28
              vertical: theme.sizing.s7,
            ),
            child: Column(
              children: [
                _buildUserInfoCard(
                  isActive: true,
                  text: user.entity?.fullName ?? '',
                  labelText: OnboardingConstants.fullNameLabel,
                  icon: OnboardingConstants.fullNameIcon,
                  controller: _nameController,
                ),
                SizedBox(height: theme.sizing.s7),
                const MinyDivider(),
                SizedBox(height: theme.sizing.s7),
                _buildUserInfoCard(
                  text: _truncateEmail(user.entity?.email ?? ''),
                  icon: OnboardingConstants.emailIcon,
                  labelText: OnboardingConstants.emailLabel,
                ),
                SizedBox(height: theme.sizing.s7),
                const MinyDivider(),
                SizedBox(height: theme.sizing.s7),
                _buildUserInfoCard(
                  text: user.entity?.mobileNumber ?? '',
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

  String _truncateEmail(String email, {int maxLength = 7}) {
    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];
    if (username.length <= maxLength) {
      return email;
    }
    final truncatedUsername = '${username.substring(0, maxLength)}...';
    return '$truncatedUsername@$domain';
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
      padding: EdgeInsets.symmetric(horizontal: theme.sizing.s7),
      child: Row(
        children: [
          MinyContainer(child: Icon(icon, size: theme.sizing.s5)),
          SizedBox(width: theme.spacing.s16),
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
                SizedBox(width: theme.spacing.s16),
                isActive
                    ? TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
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
                        color:
                            isActive
                                ? theme.colors.textPrimary
                                : theme.colors.textSecondarylight,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapconfirm() {
    FocusScope.of(context).unfocus();
    final name = _nameController.text.trim();
    setState(() {
      if (name.isEmpty) {
        _errorText = OnboardingConstants.nameEmpty;
      } else {
        store.updateCopyUserInfo(fullName: name);
        widget.onTap.call();
        _errorText = null;
      }
    });
  }
}
