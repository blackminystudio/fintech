import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';
import 'greeting_card.dart';
import 'notifiacation_button.dart';
import 'profile_progress.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    required this.theme,
    super.key,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) => Padding(
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
      );
}
