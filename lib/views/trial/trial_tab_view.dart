import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class TrialTabView extends StatelessWidget {
  final int selectedTabId;

  const TrialTabView({
    super.key,
    required this.selectedTabId,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTabId == 1) {
      return _buildAvailableTrialsSection(context);
    } else {
      return Center(
        child: Text(
          _getTabContentText(),
          style: const TextStyle(fontSize: 20, color: gray),
        ),
      );
    }
  }

  Widget _buildAvailableTrialsSection(BuildContext context) {
    return Container();
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