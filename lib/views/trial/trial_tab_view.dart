import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import 'available_trials_section.dart';
import 'active_trial_section.dart';

class TrialTabView extends StatelessWidget {
  final int selectedTabId;

  const TrialTabView({
    super.key,
    required this.selectedTabId,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTabId == 1) {
      return const AvailableTrialsSection();
    } else if (selectedTabId == 2) {
      return const ActiveTrialSection();
    } else {
      return Center(
        child: Text(
          _getTabContentText(),
          style: const TextStyle(fontSize: 20, color: gray),
        ),
      );
    }
  }

  String _getTabContentText() {
    switch (selectedTabId) {
      case 2:
        return 'My Trial';
      default:
        return 'Content not available.';
    }
  }
}