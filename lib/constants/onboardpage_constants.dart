import 'package:flutter/material.dart';

class OnboardpageConstants {
  // LoginPage_Texts
  static const String progressText = '11% completed';
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

  // Icons

  static const IconData fullNameIcon = Icons.person_outline;
  static const IconData emailIcon = Icons.email_outlined;
  static const IconData phoneIcon = Icons.call_outlined;
  static const IconData backIcon = Icons.arrow_back_ios_new;
  static const IconData infoIcon = Icons.error_outline;
}
