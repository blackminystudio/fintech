import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../store/onboarding_store.dart';
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

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _handlePageListener();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  void _onPopInvokedWithResult(bool didPop, dynamic result) {
    if (didPop) return;

    if (pageIndex > 0) {
      goToPreviousPage();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: pageIndex == 0,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        backgroundColor: theme.colors.neutralLight,
        body: SafeArea(
          child: Column(
            children: [
              Consumer(builder: (context, ref, _) {
                final info = ref.watch(userProfileProvider).info;
                return ProgressHeader(
                  progressValue: info?.getPercentage() ?? 0.0,
                  onTapSkip: () {},
                  onTapBack: goToPreviousPage,
                );
              }),
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
                    PersonalInfoScreen(
                      cityList: cityList,
                      onTap: goToNextPage,
                    ),
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
}
