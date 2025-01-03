import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/categories/categories_bloc.dart';
import 'package:trizy_app/bloc/categories/categories_event.dart';
import 'package:trizy_app/bloc/categories/categories_state.dart';
import 'package:trizy_app/bloc/trendingsearch/trending_search_bloc.dart';
import 'package:trizy_app/bloc/trendingsearch/trending_search_event.dart';
import 'package:trizy_app/bloc/trendingsearch/trending_search_state.dart';
import 'package:trizy_app/components/category_card.dart';
import 'package:trizy_app/theme/text_styles.dart';
import '../../components/top_bar_with_search_field.dart';
import '../../components/trending_search_term_item.dart';
import '../../models/category/category.dart';

class SearchPage extends StatefulWidget {
  final bool isTrial;

  const SearchPage({super.key, required this.isTrial});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  late CategoriesBloc categoriesBloc;
  late TrendingSearchBloc trendingSearchBloc;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchFocusNode = FocusNode();

    categoriesBloc = CategoriesBloc();
    trendingSearchBloc = TrendingSearchBloc();

    categoriesBloc.add(const CategoriesRequested(categoryId: null));
    trendingSearchBloc.add(TrendingSearchesRequested());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    categoriesBloc.close();
    trendingSearchBloc.close();
    super.dispose();
  }

  void onSearchCompleted(String value) {
    if (widget.isTrial) {
      context.pushNamed(
        'trialProductListPageWithQuery',
        queryParameters: {
          'query': value,
        },
      );
    } else {
      context.pushNamed(
        'productListPageWithQuery',
        queryParameters: {
          'query': value,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarWithSearchField(
                controller: searchController,
                onBackClicked: () {
                  context.pop();
                },
                text: widget.isTrial
                    ? "Search available products..."
                    : "Search anything...",
                onSearchCompleted: onSearchCompleted,
                focusNode: searchFocusNode,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child:
                Text("Top Categories", style: AppTextStyles.headlineSmall),
              ),
              const SizedBox(height: 10),

              // Horizontal Scrollable Category List
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
                    } else if (state.isSuccess &&
                        state.categoriesResponse != null) {
                      final categories = state.categoriesResponse!.categories;

                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final Category category = categories[index];
                            return Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: CategoryCard(
                                category: category,
                                onCategoryClicked: () {
                                  if (widget.isTrial) {
                                    context.pushNamed(
                                      'trialProductListPageWithCategory',
                                      pathParameters: {
                                        'categoryId': category.id,
                                        'categoryName': category.name,
                                      },
                                    );
                                  } else {
                                    context.pushNamed(
                                      'productListPageWithCategory',
                                      pathParameters: {
                                        'categoryId': category.id,
                                        'categoryName': category.name,
                                      },
                                    );
                                  }
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

              // Content Area
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("Trending Searches",
                    style: AppTextStyles.headlineSmall),
              ),

              BlocProvider(
                create: (_) => trendingSearchBloc,
                child: BlocBuilder<TrendingSearchBloc, TrendingSearchState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state.isFailure) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: Text("Failed to load trending searches!")),
                      );
                    } else if (state.isSuccess && state.trendingSearchResponse != null) {
                      final trendingSearches = state.trendingSearchResponse!.trendingSearches;
                      return Column(
                        children: [
                          ...trendingSearches.map((search) {
                            return TrendingSearchItem(
                              searchTerm: search.trendingSearchTerm,
                              onTap: () {
                                onSearchCompleted(search.trendingSearchTerm);
                              },
                            );
                          }),
                        ],
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: Text("No trending searches available")),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}