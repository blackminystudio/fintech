import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';
import '../widgets/greeting_card.dart';
import '../widgets/notifiacation_button.dart';
import '../widgets/profile_progress.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colors.neutralLight,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.width.s32,
          ),
          child: Column(
            children: [
              SizedBox(height: theme.spacing.height.s20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.width.s8,
                ),
                child: Row(
                  children: [
                    const GreetingCard(
                      greetingIcon: HomePageConstants.greetingIcon,
                      greetingMeassage: HomePageConstants.greetingMessage,
                      userName: HomePageConstants.userName,
                    ),
                    const Spacer(),
                    const NotifiactionButton(
                      icon: HomePageConstants.notificationIcon,
                    ),
                    SizedBox(width: theme.spacing.width.s12),
                    const ProfileProgress(
                      profilePictureUrl: HomePageConstants.profileImageUrl,
                      progressValue: 0.7,
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
