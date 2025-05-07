import 'package:flutter/material.dart';

class OnboardingConstants {
  // LoginPage_Texts
  static const String progressText = ' completed';
  static const String skipText = 'Skip';
  static const String enterMobileText = 'Enter your mobile\nnumber';
  static const String otpSubText = "We'll send you a quick OTP\nto verify.";
  static const String verifyButtonText = 'Verify mobile number';
  static const String mobileValidationError =
      'Your mobile number should be of 10 digits';
  static const String countryCode = '+91';

// OtpPage_Text
  static const String otpHeading = 'OTP Please?';
  static const String otpSentText = 'We’ve sent it to +91 8328818988';
  static const String otpError = 'OTP incorrect, try again?';
  static const String resendOtp = 'Resend OTP';
  static const String resendIn = 'Resend in ';
  static const String submitOtp = 'Submit OTP';
  static const String otpValidationError = 'OTP should be 6 digits';

  // BasicInfoPage_Texts
  static const String name = 'Satyabrata Nayak';
  static const String fullNameLabel = 'Full Name';
  static const String emailLabel = 'Email Address';
  static const String email = 'satyabrat...@gmail.com';
  static const String phoneLabel = 'Mobile Number';
  static const String phoneNumber = '8328818988';
  static const String basicInfoTitle = 'Confirm your basic info';
  static const String basicInfoSubtitle =
      'Your name and emailId are the identifier for friends who using this app so check correctly';
  static const String basicInfoFooterNote =
      'This is where you will receive all important communications.';
  static const String confirmButtonText = 'Confirm';

  // Personal Information Texts
  static const String personalInfoTitle = 'Personal Information';
  static const String personalInfoNote =
      'Your information is not necessary for us, you are free to ignore this section';
  static const String enterCityText = 'Enter your city';
  static const String genderLabel = 'GENDER';
  static const String maritalStatusLabel = 'MARITAL STATUS';
  static const String cityLabel = 'CITY';
  static const String continueButtonText = 'Continue';
  // Gender Optionss
  static const String male = 'Male';
  static const String female = 'Female';
  static const String other = 'Other';

  // Marital Status Options
  static const String single = 'Single';
  static const String married = 'Married';

  // Birthday Info
  static const String birthdayQuestion = 'When is your\nBirthday?';
  static const String birthdayNote =
      'We again don’t need your birthday, but we can wish you on your next birthday.';
  static const String dobLabel = 'Date of Birth';
  static const String okayButtonText = 'Okay';

// Financial Info
  static const String financialInfoTitle = 'Financial Information';
  static const String monthlyIncomeLabel = 'MONTHLY INCOME';
  static const String employmentStatusLabel = 'EMPLOYMENT STATUS';

  // Tag Info
  static const String income0to10k = '0 - 10k';
  static const String income10kto50k = '10k - 50k';
  static const String income50kto100k = '50k - 100k';
  static const String income100kto500k = '100k -500k';

  // Employment Status Options
  static const String unemployed = 'Un-employed';
  static const String student1 = 'Student';
  static const String privateJob = 'Private Job';
  static const String governmentJob = 'Government Job';
  static const String professional = 'Professional';
  static const String retired = 'Retired';
  // Icons

  static const IconData fullNameIcon = Icons.person_outline;
  static const IconData emailIcon = Icons.email_outlined;
  static const IconData phoneIcon = Icons.call_outlined;
  static const IconData backIcon = Icons.arrow_back_ios_new;
  static const IconData infoIcon = Icons.error_outline;
  static const IconData calenderIcon = Icons.calendar_month;
}
