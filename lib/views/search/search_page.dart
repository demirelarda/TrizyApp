import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/components/top_bar_with_search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void onSearchCompleted(String value) {
    print("Search Submitted: $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBarWithSearchField(
            controller: searchController,
            onBackClicked: () {
              Navigator.of(context).pop();
            },
            onSearchCompleted: onSearchCompleted,
            focusNode: searchFocusNode,
          ),

          const Expanded(
            child: Center(
              child: Text(
                "Search Results Here",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}