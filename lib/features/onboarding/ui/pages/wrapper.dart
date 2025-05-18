import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/progress_header.dart';
import 'basic_info_page.dart';
import 'dob_page.dart';
import 'financial_info_page.dart';
import 'number_page.dart';
import 'otp_page.dart';
import 'personal_info_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  double progressValue = 0.11;
  int pageIndex = 0;
  String number = '';
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
              ProgressHeader(
                progressValue: progressValue,
                onTapSkip: () {},
                onTapBack: goToPreviousPage,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NumberPage(
                      onTap: (number) {
                        log('Logger: OTP Send To this number $number');
                        this.number = number;
                        goToNextPage();
                      },
                    ),
                    OtpPage(
                      number: number,
                      correctOtp: '123412',
                      onTap: goToNextPage,
                      onResendOtp: () {
                        log('Logger: RESEND');
                      },
                    ),
                    BasicInfoPage(
                      email: OnboardingConstants.email,
                      number: number,
                      onTap: (name) {
                        log('Logger: $name');
                        goToNextPage();
                      },
                    ),
                    PersonalInfoPage(
                      cityList: [
                        'New York',
                        'Los Angeles',
                        'Chicago',
                        'Québec',
                        'Düsseldorf',
                        'akksfkjdkfkdsjfkdkfjkdsjjfkjsdkfjksdjfkdsjfksdjkfjs',
                        'Houston',
                        'Phoenix',
                      ],
                      onTap: (gender, maritalStatus) {
                        log('Logger: $gender, $maritalStatus');
                        goToNextPage();
                      },
                    ),
                    DobPage(
                      onTap: (dob) {
                        goToNextPage();
                      },
                    ),
                    FinancialInfoPage(
                      onTap: (income, employment) {
                        log('Logger: $income, $employment');
                      },
                    ),
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
