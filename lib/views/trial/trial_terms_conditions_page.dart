import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';

class TrialTermsConditionsPage extends StatefulWidget {
  const TrialTermsConditionsPage({super.key});

  @override
  State<TrialTermsConditionsPage> createState() =>
      _TrialTermsConditionsPageState();
}

class _TrialTermsConditionsPageState extends State<TrialTermsConditionsPage> {
  String _terms = "Loading terms and conditions...";

  @override
  void initState() {
    super.initState();
    _loadTerms();
  }

  Future<void> _loadTerms() async {
    try {
      final terms = await rootBundle.loadString('assets/terms/trial_terms.md');
      setState(() {
        _terms = terms;
      });
    } catch (e) {
      setState(() {
        _terms = "Failed to load terms and conditions.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarWithBackButton(
        onBackClicked: () {
          context.pop();
        },
        title: "Product Trialing Terms",
      ),
      body: Markdown(
        data: _terms,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
      ),
    );
  }
}