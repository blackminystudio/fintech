import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../store/onboarding_store.dart';
import '../widgets/progress_header.dart';
import 'basic_info_page.dart';
import 'dob_page.dart';
import 'financial_info_page.dart';
import 'number_page.dart';
import 'otp_page.dart';
import 'personal_info_page.dart';

const cityList = [
  'New York',
  'Los Angeles',
  'Chicago',
  'Québec',
  'Düsseldorf',
  'akksfkjdkfkdsjfkdkfjkdsjjfkjsdkfjksdjfkdsjfksdjkfjs',
  'Houston',
  'Phoenix',
];

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  double progressValue = 0.11;
  String number = '';
  int pageIndex = 0;
  final PageController pageController = PageController();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).unfocus();
    });
    super.initState();
    pageController.addListener(() {
      final index = pageController.page?.round();
      if (index != null && index != pageIndex) {
        setState(() {
          pageIndex = index;
        });
      }
    });
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
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

  void updateProgressValue(double value) {
    setState(() {
      progressValue = value;
    });
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
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NumberPage(onTap: goToNextPage),
                    OtpPage(
                      correctOtp: '123412',
                      onResendOtp: () {},
                      onTap: goToNextPage,
                    ),
                    BasicInfoPage(onTap: goToNextPage),
                    PersonalInfoPage(
                      cityList: cityList,
                      onTap: goToNextPage,
                    ),
                    DobPage(onTap: goToNextPage),
                    FinancialInfoPage(onTap: () {}),
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
