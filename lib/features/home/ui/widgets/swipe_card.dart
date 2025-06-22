import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';

class SwipeCard extends StatefulWidget {
  const SwipeCard({
    required this.currentBalance,
    required this.debitedBalance,
    required this.creditedBalance,
    required this.bankLogo,
    super.key,
  });

  final String currentBalance;
  final String debitedBalance;
  final String creditedBalance;
  final String bankLogo;

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        // Background with Gradient and Mask
        Container(
          decoration: ShapeDecoration(
            gradient: theme.colors.gradientDark,
            shape: SmoothRectangleBorder(
              side: BorderSide(
                color: theme.colors.neutralBorder,
              ),
              borderRadius: SmoothBorderRadius(
                cornerRadius: theme.borderradius.large,
                cornerSmoothing: 1,
              ),
            ),
          ),
          child: SvgPicture.asset(
            HomeImagePaths.swipCardMask,
            fit: BoxFit.fill,
          ),
        ),

        // Main Content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.width.s32,
            vertical: theme.spacing.height.s32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SECTION: Current Balance and Bank Logo
              Row(
                children: [
                  _buildCurrentBalance(),
                  const Spacer(),
                  _buildBankLogo(widget.bankLogo),
                ],
              ),
              SizedBox(height: theme.spacing.height.s40),

              // SECTION: Debited and Credited Info
              _buildTransactionRow(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentBalance() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              HomeConstants.currentBalanceLabel,
              style: theme.textStyle.bodySmall.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
            SizedBox(width: theme.spacing.width.s4),
            GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(theme.spacing.width.s4),
                // TODO: Icon check
                child: Icon(
                  obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  size: theme.sizing.width.s4,
                  color: theme.colors.textSecondary,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: theme.spacing.height.s4),
        Text(
          obscureText
              ? HomeConstants.obscureBalance
              : '₹${widget.currentBalance}',
          style: theme.textStyle.headingXxlarge.copyWith(
            color: theme.colors.neutralLight,
          ),
        ),
      ],
    );
  }

  Widget _buildBankLogo(String bankLogo) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        right: theme.spacing.width.s10,
        top: theme.spacing.height.s20,
      ),
      child: ClipOval(
        child: Image(
          height: theme.sizing.width.s12,
          width: theme.sizing.width.s12,
          image: NetworkImage(bankLogo),
        ),
      ),
    );
  }

  Widget _buildTransactionRow() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _BalanceInfo(
            icon: Iconsax.card_send,
            label: HomeConstants.debitedLabel,
            amount: widget.debitedBalance,
            iconColor: theme.colors.accentRed,
          ),
        ),
        // SizedBox(width: theme.spacing.width.s16),
        Expanded(
          child: _BalanceInfo(
            icon: Iconsax.card_send,
            label: HomeConstants.creditedLabel,
            amount: widget.creditedBalance,
            iconColor: theme.colors.accentGreen,
          ),
        ),
        // SizedBox(width: theme.spacing.width.s12),
        GestureDetector(
          onTap: () => Clipboard.setData(
            ClipboardData(text: widget.currentBalance),
          ),
          child: Padding(
            padding: EdgeInsets.all(theme.spacing.width.s8),
            child: Icon(
              Iconsax.document_copy,
              size: theme.sizing.width.s6,
              color: theme.colors.neutralBorder,
            ),
          ),
        ),
        // SizedBox(width: theme.spacing.width.s8), // Given due to space is 40-32
      ],
    );
  }
}

// SECTION: Reusable Balance Info Widget
class _BalanceInfo extends StatelessWidget {
  const _BalanceInfo({
    required this.icon,
    required this.label,
    required this.amount,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final String amount;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: theme.sizing.width.s4,
            ),
            SizedBox(width: theme.spacing.width.s4),
            Text(
              label,
              style: theme.textStyle.bodySmall.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.height.s4),
        Text(
          '₹$amount',
          style: theme.textStyle.headingLarge.copyWith(
            color: theme.colors.textSecondarylight,
          ),
        ),
      ],
    );
  }
}
