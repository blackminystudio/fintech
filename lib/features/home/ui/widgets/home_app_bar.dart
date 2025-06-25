import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';
import '../widgets/greeting_card.dart';
import '../widgets/profile_progress.dart';
import 'notification_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
                greetingMessage: HomeConstants.greetingMessage,
                userName: HomeConstants.userName,
              ),
              const Spacer(),
              NotificationButton(
                onPressed: () {},
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
      ],
    );
  }
}
