import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/categories/categories_bloc.dart';
import 'package:trizy_app/bloc/categories/categories_event.dart';
import 'package:trizy_app/bloc/categories/categories_state.dart';
import 'package:trizy_app/components/category_card.dart';
import 'package:trizy_app/components/top_bar_with_search_field.dart';
import 'package:trizy_app/theme/text_styles.dart';
import '../../models/category/category.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  late CategoriesBloc categoriesBloc;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    categoriesBloc = CategoriesBloc();
    categoriesBloc.add(const CategoriesRequested(categoryId: null));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    categoriesBloc.close();
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

          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text("Top Categories", style: AppTextStyles.headlineSmall)
          ),
          const SizedBox(height: 10),

          // horizontal Scrollable Category List
          BlocProvider(
            create: (_) => categoriesBloc,
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state.isFailure) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text("Failed to load categories!")),
                  );
                } else if (state.isSuccess && state.categoriesResponse != null) {
                  final categories = state.categoriesResponse!.categories;

                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final Category category = categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: CategoryCard(
                            category: category,
                            onCategoryClicked: () {
                              print("Clicked on: ${category.name}");

                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text("No categories available")),
                  );
                }
              },
            ),
          ),

          //Content Area

          const SizedBox(height: 10),
          const Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Trending Searches", style: AppTextStyles.headlineSmall)
              ),
            ],
          )
        ],
      ),
    );
  }
}