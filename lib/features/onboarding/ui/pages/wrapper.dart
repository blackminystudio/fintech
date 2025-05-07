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
  final PageController pageController = PageController();

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.neutralLight,
      body: SafeArea(
        child: Column(
          children: [
            ProgressHeader(
              progressValue: 0.33,
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
                    },
                  ),
                  OtpPage(
                    onTap: goToNextPage,
                    onResendOtp: () {
                      log('Logger: RESEND');
                    },
                    correctOtp: '123412',
                  ),
                  BasicInfoPage(
                    onTap: (name) {
                      log('Logger: $name');
                      goToNextPage();
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
    );
  }
}
