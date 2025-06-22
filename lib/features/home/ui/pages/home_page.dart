import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';
import '../widgets/greeting_card.dart';
import '../widgets/notifiacation_button.dart';
import '../widgets/profile_progress.dart';
import '../widgets/swipe_card.dart';

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
                      greetingIcon: HomeConstants.greetingIcon,
                      greetingMeassage: HomeConstants.greetingMessage,
                      userName: HomeConstants.userName,
                    ),
                    const Spacer(),
                    const NotifiactionButton(
                      icon: HomeConstants.notificationIcon,
                    ),
                    SizedBox(width: theme.spacing.width.s12),
                    const ProfileProgress(
                      profilePictureUrl: HomeImagePaths.profileImageUrl,
                      progressValue: 0.7,
                    ),
                  ],
                ),
              ),
              // TODO: Need s28
              SizedBox(height: theme.spacing.height.s32),
              const SwipeCard(
                currentBalance: '18,425',
                debitedBalance: '32,200',
                creditedBalance: '50,625',
                bankLogo: HomeImagePaths.bankLogo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
