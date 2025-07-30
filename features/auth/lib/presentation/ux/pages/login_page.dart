import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/util/router/home_router.gr.dart';

import '../../../auth.dart';
import '../../../util/constants/auth_constants.dart';
import '../../store/src/auth_state.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStoreProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authStoreProvider, (prev, next) {
      final e = next.exception;
      if (e != null && e.errorType == ErrorType.signinCancelled) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AuthConstants.cancelledSignIn,
              style: theme.textStyle.bodySmall,
            ),
            showCloseIcon: true,
            duration: const Duration(milliseconds: 1000),
          ),
        );
      }
    });

    Future<void> _handleLogin() async {
      await ref.read(authStoreProvider.notifier).signInWithGoogle();
      await context.router.replace(const HomeRoute());
    }

    return Scaffold(
      backgroundColor: theme.colors.neutralLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.width.s32),
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
              MinyButton(
                enableIcon: true,
                isLoading: isLoading,
                onPressed: _handleLogin,
                label: AuthConstants.googleButtonLabel,
              ),
              SizedBox(height: theme.spacing.height.s40),
            ],
          ),
        ),
      ),
    );
  }
}
