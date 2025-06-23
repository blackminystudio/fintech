import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeConstants {
  // Greeting
  static const String greetingMessage = 'Good Morning';
  static const String userName = 'John Doe';
  static const String currentBalanceLabel = 'Current Balance';
  static const String debitedLabel = 'Debited';
  static const String creditedLabel = 'Credited';
  static const String obscureBalance = '*******';

  // Icons
  static const IconData greetingIcon = Iconsax.cloud_sunny;
  static const IconData notificationIcon = Iconsax.notification_bing;
}

class HomeImagePaths {
  static const String swipeCardMask = 'assets/images/card_mask.svg';
  static const String profileImageUrl =
      'https://media.licdn.com/dms/image/v2/D5603AQHARtfrhpGEvQ/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1728052413832?e=1755734400&v=beta&t=A0RWhHuOMsgsXTGrHnOY7P1MT_l-LJN4qUgaZwvtD0k';
  static const String bankLogo =
      'https://smest.in/_next/image?url=https%3A%2F%2Fissuer-master-article-logos.s3.ap-south-1.amazonaws.com%2FAUBANK.png&w=3840&q=75';
}
