import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../store/onboarding_store_provider.dart';
import '../../store/src/onboarding_state.dart';
import '../widgets/progress_header.dart';
import 'screens/basic_info_screen.dart';
import 'screens/dob_screen.dart';
import 'screens/financial_info_screen.dart';
import 'screens/number_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/personal_info_screen.dart';

const cityList = [
  'New York',
  'Los Angeles',
  'Chicago',
  'Québec',
  'Düsseldorf',
  'Houston',
  'Phoenix',
];

@RoutePage()
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingStoreProvider);
    if (state.status == OnboardingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final theme = Theme.of(context);
    return PopScope(
      canPop: pageIndex == 0,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        backgroundColor: theme.colors.neutralLight,
        body: SafeArea(
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, _) {
                  final info =
                      ref.watch(onboardingStoreProvider).onboardingEntity;
                  return ProgressHeader(
                    progressValue: info?.getPercentage() ?? 0.0,
                    onTapSkip: () async {
                      final store = ref.read(onboardingStoreProvider.notifier);
                      await store.updateCopyUserInfo(toUpdate: true);
                      _showSkipConfirmation(context);
                    },
                    onTapBack: goToPreviousPage,
                  );
                },
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NumberScreen(onTap: goToNextPage),
                    OtpScreen(
                      correctOtp: '123412',
                      onResendOtp: () {},
                      onTap: goToNextPage,
                    ),
                    BasicInfoScreen(onTap: goToNextPage),
                    PersonalInfoScreen(cityList: cityList, onTap: goToNextPage),
                    DobScreen(onTap: goToNextPage),
                    FinancialInfoScreen(onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _handlePageListener();
  }

  void _handlePageListener() {
    _pageController.addListener(() {
      final index = _pageController.page?.round();
      if (index != null && index != pageIndex) {
        setState(() {
          pageIndex = index;
        });
      }
    });
  }

  void _onPopInvokedWithResult(bool didPop, dynamic result) {
    if (didPop) return;

    if (pageIndex > 0) {
      goToPreviousPage();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _showSkipConfirmation(BuildContext context) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colors.neutralLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(theme.sizing.s5),
        ),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.all(theme.spacing.s24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Skip Onboarding', style: theme.textStyle.headingMedium),
                SizedBox(height: theme.spacing.s12),
                Text(
                  'Are you sure you want to skip onboarding? ',
                  style: theme.textStyle.bodyMedium,
                ),
                SizedBox(height: theme.spacing.s24),
                Row(
                  children: [
                    Expanded(
                      child: MinyButton(
                        onPressed: () => Navigator.pop(context),
                        label: 'Cancel',
                      ),
                    ),
                    SizedBox(width: theme.spacing.s12),
                    Expanded(
                      child: MinyButton(
                        onPressed: () async {
                          await context.router.replacePath('/home');
                        },
                        label: 'Skip',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
