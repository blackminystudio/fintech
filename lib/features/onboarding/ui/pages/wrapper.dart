import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

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
  double progressValue = 0.00;
  int pageIndex = 0;
  final PageController pageController = PageController(initialPage: 3);
  @override
  void initState() {
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
                        goToNextPage();
                        updateProgressValue(0.11);
                      },
                    ),
                    OtpPage(
                      correctOtp: '123412',
                      onTap: goToNextPage,
                      onResendOtp: () {
                        log('Logger: RESEND');
                        updateProgressValue(0.22);
                      },
                    ),
                    BasicInfoPage(
                      onTap: (name) {
                        log('Logger: $name');
                        goToNextPage();
                        progressValue = 0.30;
                      },
                    ),
                    PersonalInfoPage(
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
