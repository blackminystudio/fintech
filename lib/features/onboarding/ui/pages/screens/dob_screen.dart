import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:miny_design_system/miny_design_system.dart';

import '../../../store/onboarding_store.dart';
import '../../../utilities/onboarding_constants.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/onboarding_title.dart';

class DobScreen extends ConsumerStatefulWidget {
  final VoidCallback onTap;

  const DobScreen({
    super.key,
    required this.onTap,
  });

  @override
  ConsumerState<DobScreen> createState() => _DobPageState();
}

class _DobPageState extends ConsumerState<DobScreen> {
  DateTime? selectedDate;
  DateTime tempDate = DateTime(2000);
  late UserProfileStore store;

  @override
  void initState() {
    super.initState();
    store = ref.read(userProfileProvider.notifier);
    final info = ref.read(userProfileProvider).info;
    selectedDate = info?.dateOfBirth;
  }

  void _onTapOkay() {
    setState(() {
      selectedDate = tempDate;
    });
    Navigator.pop(context);
  }

  void _onTapContinue() {
    if (selectedDate != null) {
      widget.onTap.call();
      store.updateCopyUserInfo(dateOfBirth: selectedDate);
    }
    return;
  }

  void _showDatePicker(BuildContext context) {
    final theme = Theme.of(context);
    tempDate = selectedDate ?? DateTime(2000);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colors.neutralLight,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(theme.borderradius.large)),
      ),
      builder: (context) => _buildDatePickerSheet(theme),
    );
  }

  Widget _buildDatePickerSheet(
    ThemeData theme,
  ) =>
      Padding(
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
              onPressed: _onTapOkay,
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
          onTap: _onTapContinue,
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
