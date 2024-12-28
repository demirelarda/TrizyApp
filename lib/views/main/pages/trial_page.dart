import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/views/trial/trial_tab_view.dart';
import '../../../components/horizontal_scroll_widget.dart';
import '../../../components/textfields/non_editable_field.dart';

class TrialPage extends StatefulWidget {
  const TrialPage({super.key});

  @override
  State<TrialPage> createState() => _TrialPageState();
}

class _TrialPageState extends State<TrialPage> {

  int selectedTabId = 1;

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Available for Trialing'},
    {'id': 2, 'name': 'My Trial'}
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Top bar
          Container(
            color: primaryLightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Search bar
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 8.0,
                  ),
                  child: NonEditableField(
                    placeholder: "Search available products...",
                    icon: Icons.search,
                    onTap: () {
                      context.pushNamed('searchTrial');
                    },
                  ),
                ),
                // Horizontal item selector
                HorizontalScrollWidget(
                  items: categories,
                  backgroundColor: primaryLightColorDarker,
                  onItemTap: (int id) {
                    setState(() {
                      selectedTabId = id;
                    });
                  },
                ),
              ],
            ),
          ),

          //Dynamic content based on selected tab
          Expanded(
            child: TrialTabView(
              selectedTabId: selectedTabId,
            ),
          ),
        ],
      ),
    );
  }
}
