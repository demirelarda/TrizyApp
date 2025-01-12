import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../components/horizontal_scroll_widget.dart';
import '../../../../components/textfields/non_editable_field.dart';
import '../../../../theme/colors.dart';
import 'dynamic_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTabId = 1;

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Top Deals'},
    {'id': 2, 'name': 'AI Suggestions'},
    {'id': 3, 'name': 'Best of Week'},
    {'id': 4, 'name': 'Best of Month'},
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
                    placeholder: "Search anything...",
                    icon: Icons.search,
                    onTap: () {
                      context.pushNamed('search');
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
            child: DynamicTabView(
              selectedTabId: selectedTabId,
            ),
          ),
        ],
      ),
    );
  }
}