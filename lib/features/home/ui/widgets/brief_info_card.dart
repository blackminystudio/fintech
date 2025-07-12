import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/home_constants.dart';

enum CardType {
  credit,
  debit,
}

class BriefInfoCard extends StatefulWidget {
  const BriefInfoCard({
    required this.amountList,
    required this.type,
    super.key,
  });

  final List<String> amountList;
  final CardType type;

  @override
  State<BriefInfoCard> createState() => _BriefInfoCardState();
}

class _BriefInfoCardState extends State<BriefInfoCard> {
  late int _currentIndex;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.amountList.length - 1;
    _now = DateTime.now();
  }

  ({bool isCredit, IconData icon}) _getCardMeta() {
    final isCredit = widget.type == CardType.credit;
    final icon = isCredit ? Iconsax.import_15 : Iconsax.export5;
    return (isCredit: isCredit, icon: icon);
  }

  ({double currentAmount, double previousAmount, double percentageValue})
      _getAmounts() {
    final current = double.tryParse(widget.amountList[_currentIndex]) ?? 0.0;
    final previous = _currentIndex == 0
        ? 0.0
        : double.tryParse(widget.amountList[_currentIndex - 1]) ?? 0.0;
    final percentage =
        previous == 0.0 ? 0.0 : ((current - previous) / previous) * 100;

    return (
      currentAmount: current,
      previousAmount: previous,
      percentageValue: percentage,
    );
  }

  String _percentageLabel(double value) {
    if (value > 0) {
      return '+${value.toStringAsFixed(0)}';
    } else if (value < 0) {
      return '-${value.abs().toStringAsFixed(0)}';
    } else {
      return '0';
    }
  }

// TODO:DS  Add Color(0xFFEE4E4E)

  Color _percentageColor(ThemeData theme, double percentage, bool isCredit) =>
      isCredit
          ? (percentage > 0
              ? theme.colors.accentGreen
              : theme.colors.textSecondary)
          : (percentage > 0
              ? const Color(0xFFEE4E4E)
              : theme.colors.textSecondary);

  Color _cardColor(ThemeData theme, bool isCredit) =>
      isCredit ? theme.colors.accentGreen : const Color(0xFFEE4E4E);

  String _monthLabel(int indexFromLast) {
    final targetMonth = DateTime(_now.year, _now.month - indexFromLast);
    return DateFormat('MMMM').format(targetMonth).toUpperCase();
  }

  void _onTapAmountChange() {
    if (widget.amountList.length < 3) return;
    setState(() {
      _currentIndex =
          _currentIndex == 1 ? widget.amountList.length - 1 : _currentIndex - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardMeta = _getCardMeta();
    return _buildOuterContainer(theme, cardMeta);
  }

  Widget _buildOuterContainer(
          ThemeData theme, ({bool isCredit, IconData icon}) cardMeta) =>
      Container(
        decoration: ShapeDecoration(
          color: _cardColor(theme, cardMeta.isCredit),
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerSmoothing: 1,
                cornerRadius: theme.borderradius.large,
              ),
            ),
          ),
        ),
        padding: EdgeInsets.only(
          left: theme.spacing.width.s12,
          right: theme.spacing.width.s1,
          top: theme.spacing.height.s1,
          bottom: theme.spacing.height.s1,
        ),
        child: _buildInnerCard(theme, cardMeta),
      );

  Widget _buildInnerCard(
          ThemeData theme, ({bool isCredit, IconData icon}) cardMeta) =>
      Container(
        // TODO: check or Add height and width
        height: 92,
        width: 194,
        decoration: ShapeDecoration(
          color: theme.colors.neutralLight,
          shape: SmoothRectangleBorder(
            side: BorderSide(
              width: theme.spacing.width.s2,
              color: _cardColor(theme, cardMeta.isCredit),
            ),
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerSmoothing: 1,
                cornerRadius: theme.borderradius.large,
              ),
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.height.s12,
          horizontal: theme.spacing.width.s12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTopRow(theme, cardMeta),
            _buildBottomRow(theme, cardMeta),
          ],
        ),
      );

  Widget _buildTopRow(
          ThemeData theme, ({bool isCredit, IconData icon}) cardMeta) =>
      Row(
        children: [
          Padding(
            padding: EdgeInsets.all(theme.spacing.width.s2),
            child: Icon(
              cardMeta.icon,
              size: theme.sizing.width.s4,
              color: _cardColor(theme, cardMeta.isCredit),
            ),
          ),
          SizedBox(width: theme.spacing.width.s2),
          Text(
            _monthLabel(widget.amountList.length - 1 - _currentIndex),
            style: theme.textStyle.headingXxsmall.copyWith(
              color: theme.colors.textSecondarylight,
            ),
          ),
        ],
      );

  Widget _buildBottomRow(
      ThemeData theme, ({bool isCredit, IconData icon}) cardMeta) {
    final amounts = _getAmounts();
    final percentageLabel = _percentageLabel(amounts.percentageValue);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$percentageLabel${HomeConstants.percentage}',
          style: theme.textStyle.headingSmall.copyWith(
            color: _percentageColor(
                theme, amounts.percentageValue, cardMeta.isCredit),
          ),
        ),
        GestureDetector(
          onTap: _onTapAmountChange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${HomeConstants.currency}'
                '${amounts.currentAmount.toStringAsFixed(0)}',
                style: theme.textStyle.headingLarge.copyWith(
                  color: theme.colors.textPrimary,
                ),
              ),
              // TODO:DS  Add Color(0xFF7A787C),  Color(0xFFC8C8C8);
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF7A787C),
                    Color(0xFFC8C8C8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  '${HomeConstants.currency}'
                  '${amounts.previousAmount.toStringAsFixed(0)}',
                  style: theme.textStyle.headingSmall.copyWith(
                    color: theme.colors.neutralLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
