import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/utils/auth_check.dart';
import 'package:trizy_app/views/main/pages/home/ai_suggestions_section.dart';
import '../../../../theme/colors.dart';
import 'deals_section.dart';

class DynamicTabView extends StatelessWidget {
  final int selectedTabId;

  const DynamicTabView({
    super.key,
    required this.selectedTabId,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTabId == 1) {
      return const DealsSection();
    } else if (selectedTabId == 2) {
      return FutureBuilder<bool>(
        future: isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pushNamed("login");
            });
            return const SizedBox.shrink();
          } else {
            return const AiSuggestionsSection();
          }
        },
      );
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
      case 3:
        return 'Best of Month coming soon!';
      case 4:
        return 'Best of Year coming soon!';
      default:
        return 'Content not available.';
    }
  }
}