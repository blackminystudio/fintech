import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../util/constants/onboarding_constants.dart';
import '../../../store/onboarding_store_provider.dart';
import '../../../store/src/onboarding_store.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/onboarding_title.dart';

class DobScreen extends ConsumerStatefulWidget {
  const DobScreen({required this.onTap, super.key});
  final VoidCallback onTap;

  @override
  ConsumerState<DobScreen> createState() => _DobPageState();
}

class _DobPageState extends ConsumerState<DobScreen> {
  DateTime? selectedDate;
  DateTime userSelectionDate = DateTime(2000);
  late OnboardingStore store;

  @override
  void initState() {
    super.initState();
    store = ref.read(onboardingStoreProvider.notifier);
    final info = ref.read(onboardingStoreProvider).entity;
    selectedDate = info?.dateOfBirth;
  }

  void _onTapOkay() {
    setState(() {
      selectedDate = userSelectionDate;
    });
    store.updateCopyUserInfo(dateOfBirth: selectedDate);
    Navigator.pop(context);
  }

  void _onTapContinue() {
    widget.onTap.call();
    store.updateCopyUserInfo(dateOfBirth: selectedDate);
  }

  void _showDatePicker(BuildContext context) {
    final theme = Theme.of(context);
    userSelectionDate = selectedDate ?? DateTime(2000);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colors.neutralLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.borderradius.large),
          topRight: Radius.circular(theme.borderradius.large),
        ),
      ),
      builder: (context) => _buildDatePickerSheet(theme),
    );
  }

  Widget _buildDatePickerSheet(ThemeData theme) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: theme.spacing.s24,
      vertical: theme.spacing.s40,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: theme.sizing.s64,
          child: CupertinoDatePicker(
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: userSelectionDate,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              userSelectionDate = newDate;
            },
          ),
        ),
        SizedBox(height: theme.spacing.s4),
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
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.s32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingTitle(
                  title: OnboardingConstants.birthdayQuestion,
                  subTitle: OnboardingConstants.birthdayNote,
                ),
                SizedBox(height: theme.spacing.s32),
                DateSelectorTile(
                  selectedDate: selectedDate,
                  onTap: () => _showDatePicker(context),
                ),
              ],
            ),
          ),
        ),
        BottomActionBar(
          label: OnboardingConstants.continueButtonText,
          onTap: (selectedDate != null) ? _onTapContinue : null,
        ),
      ],
    );
  }
}

class DateSelectorTile extends StatelessWidget {
  const DateSelectorTile({
    required this.selectedDate,
    required this.onTap,
    super.key,
  });
  final DateTime? selectedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate =
        selectedDate == null
            ? OnboardingConstants.dobLabel
            : DateFormat('dd-MM-yyyy').format(selectedDate!);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: theme.spacing.s20,
          horizontal: theme.spacing.s20,
        ),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            side: BorderSide(color: theme.colors.neutralBorder),
            borderRadius: SmoothBorderRadius(
              cornerRadius: theme.borderradius.large,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(theme.spacing.s10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(theme.borderradius.small),
                color: theme.colors.neutralLightBackground,
              ),
              child: Icon(
                OnboardingConstants.calenderIcon,
                size: theme.sizing.s6,
                color: theme.colors.textPrimary,
              ),
            ),
            SizedBox(width: theme.spacing.s16),
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
