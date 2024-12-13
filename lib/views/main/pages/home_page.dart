import 'package:flutter/material.dart';
import '../../../components/horizontal_scroll_widget.dart';
import '../../../components/textfields/non_editable_field.dart';
import '../../../theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'Top Deals'},
    {'id': 2, 'name': 'Popular This Week'},
    {'id': 3, 'name': 'Best of Month'},
    {'id': 4, 'name': 'Best of Year'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Custom App Bar
          Container(
            color: primaryLightColor,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8.0,
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
              ),
              child: NonEditableField(
                placeholder: "Search anything...",
                icon: Icons.search,
                onTap: () {

                },
              ),
            ),
          ),

          HorizontalScrollWidget(
            items: categories,
            backgroundColor: primaryLightColorDarker,
            onItemTap: (int id) {
              print("Tapped on item with ID: $id");
            },
          ),

          //content
          const Expanded(
            child: Center(
              child: Text("Home Page Content"),
            ),
          ),
        ],
      ),
    );
  }
}