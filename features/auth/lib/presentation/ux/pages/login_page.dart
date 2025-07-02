import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/util/router/home_router.gr.dart';

import '../../../auth.dart';
import '../../../util/constants/auth_constants.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    var isLoading = false;

    Future<void> _handleLogin(Function(void Function()) setState) async {
      setState(() => isLoading = true);
      await ref.read(authStoreProvider.notifier).signInWithGoogle();
      await context.router.replace(const HomeRoute());
      setState(() => isLoading = false);
    }

    return Scaffold(
      backgroundColor: theme.colors.neutralLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.width.s32,
          ),
          child: Column(
            children: [
              SizedBox(height: theme.spacing.height.s80),
              SvgPicture.asset(
                ImagePath.appLogoPath,
                height: theme.sizing.height.s32,
              ),
              SizedBox(height: theme.spacing.height.s80),
              Text(
                AuthConstants.introducingText,
                style: theme.textStyle.bodyXsmall.copyWith(
                  color: theme.colors.neutralBackground,
                ),
              ),
              SizedBox(height: theme.spacing.height.s24),
              Text(
                AuthConstants.headingText,
                textAlign: TextAlign.center,
                style: theme.textStyle.bodyXxlarge.copyWith(
                  color: theme.colors.neutralBackground,
                ),
              ),
              SizedBox(height: theme.spacing.height.s24),
              Text(
                AuthConstants.subText,
                textAlign: TextAlign.center,
                style: theme.textStyle.bodyMedium.copyWith(
                  color: theme.colors.textSecondary,
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  text: AuthConstants.termsPrefix,
                  style: theme.textStyle.bodyXsmall.copyWith(
                    color: theme.colors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: AuthConstants.termsText,
                      style: theme.textStyle.headingXsmall.copyWith(
                        color: theme.colors.neutralBackground,
                      ),
                    ),
                    TextSpan(
                      text: AuthConstants.andText,
                      style: theme.textStyle.bodyXsmall.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                    ),
                    TextSpan(
                      text: AuthConstants.privacyPolicyText,
                      style: theme.textStyle.headingXsmall.copyWith(
                        color: theme.colors.neutralBackground,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: theme.spacing.height.s20),
              StatefulBuilder(
                builder: (context, setState) => MinyButton(
                  enableIcon: true,
                  onPressed: () => _handleLogin(setState),
                  label: AuthConstants.googleButtonLabel,
                  isLoading: isLoading,
                ),
              ),
              SizedBox(height: theme.spacing.height.s40),
            ],
          ),
        ),
      ),
    );
  }
}
