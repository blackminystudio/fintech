import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../utilities/onboarding_constants.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/onboarding_title.dart';

class DobPage extends StatefulWidget {
  // TODO: this need to be nonnull
  final Function(DateTime? dob) onTap;

  const DobPage({
    super.key,
    required this.onTap,
  });

  @override
  State<DobPage> createState() => _DobPageState();
}

class _DobPageState extends State<DobPage> {
  DateTime? selectedDate;

  void _showDatePicker(BuildContext context) {
    final theme = Theme.of(context);
    final tempDate = selectedDate ?? DateTime(2000);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colors.neutralLight,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(theme.borderradius.large)),
      ),
      builder: (context) => _buildDatePickerSheet(theme, tempDate),
    );
  }

  Widget _buildDatePickerSheet(ThemeData theme, DateTime tempDate) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.sizing.width.s7,
          vertical: theme.spacing.width.s40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: theme.sizing.height.s64,
              child: CupertinoDatePicker(
                dateOrder: DatePickerDateOrder.dmy,
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  tempDate = newDate;
                },
              ),
            ),
            SizedBox(height: theme.spacing.height.s4),
            MinyButton(
              label: OnboardingConstants.okayButtonText,
              onPressed: () {
                setState(() {
                  selectedDate = tempDate;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: theme.sizing.height.s8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingTitle(
                  title: OnboardingConstants.birthdayQuestion,
                  subTitle: OnboardingConstants.birthdayNote,
                ),
                SizedBox(height: theme.spacing.height.s32),
                DateSelectorTile(
                  selectedDate: selectedDate,
                  onTap: () => _showDatePicker(context),
                ),
              ],
            ),
          ),
        ),
        BottomActionBar(
          // TODO:
          /// Errors:
          /// "Select your date of birth"
          label: OnboardingConstants.continueButtonText,
          onPressed: () => widget.onTap.call(selectedDate),
        ),
      ],
    );
  }
}

class DateSelectorTile extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const DateSelectorTile({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = selectedDate == null
        ? OnboardingConstants.dobLabel
        : DateFormat('dd-MM-yyyy').format(selectedDate!);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.height.s20,
          horizontal: theme.spacing.height.s20,
        ),
        decoration: ShapeDecoration(
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(theme.spacing.height.s10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(theme.borderradius.small),
                color: theme.colors.neutralLightBackground,
              ),
              child: Icon(
                OnboardingConstants.calenderIcon,
                size: theme.sizing.height.s6,
                color: theme.colors.textPrimary,
              ),
            ),
            SizedBox(width: theme.sizing.width.s4),
            Text(
              formattedDate,
              style: theme.textStyle.headingMedium.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
