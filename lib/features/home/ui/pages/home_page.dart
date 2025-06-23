import 'package:flutter/material.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';
import '../widgets/home_app_bar.dart';
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
          child: _buildBody(theme),
        ),
      ),
    );
  }

  Column _buildBody(ThemeData theme) => Column(
        children: [
          SizedBox(height: theme.spacing.height.s20),
          HomeAppBar(theme: theme),
          SizedBox(height: theme.spacing.height.s32),
          const SwipeCard(
            currentBalance: '18,425',
            debitedBalance: '32,200',
            creditedBalance: '50,625',
            bankLogo: HomeImagePaths.bankLogo,
          ),
        ],
      );
}
