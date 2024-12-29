import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/trial/trial_products_bloc.dart';
import 'package:trizy_app/bloc/trial/trial_products_event.dart';
import 'package:trizy_app/bloc/trial/trial_products_state.dart';
import 'package:trizy_app/components/sub_category_card.dart';
import 'package:trizy_app/components/trial_product_card.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/utils/sub_check.dart';

class TrialProductListPage extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;
  final String? query;

  const TrialProductListPage({
    super.key,
    this.categoryId,
    this.categoryName,
    this.query,
  });

  @override
  State<TrialProductListPage> createState() => _TrialProductListPageState();
}

class _TrialProductListPageState extends State<TrialProductListPage> {
  late TrialProductsBloc _trialProductsBloc;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    _trialProductsBloc = TrialProductsBloc();
    _fetchTrialProducts();

    _scrollController.addListener(() {
      final atBottom =
          _scrollController.position.pixels == _scrollController.position.maxScrollExtent;

      final canLoadMore = !_trialProductsBloc.state.isLoading &&
          _trialProductsBloc.state.trialProductsResponse?.pagination.currentPage !=
              _trialProductsBloc.state.trialProductsResponse?.pagination.totalPages;

      if (atBottom && canLoadMore) {
        _currentPage++;
        _fetchTrialProducts();
      }
    });
  }

  @override
  void dispose() {
    _trialProductsBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchTrialProducts() {
    _trialProductsBloc.add(
      TrialProductsRequested(
        categoryId: widget.categoryId,
        query: widget.query,
        page: _currentPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _trialProductsBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text(widget.categoryName ??
              (widget.query != null
                  ? '"${widget.query}"'
                  : "Trial Products")),
          centerTitle: true,
        ),
        body: BlocBuilder<TrialProductsBloc, TrialProductsState>(
          builder: (context, state) {
            if (state.isLoading && _currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  "Failed to load trial products. ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.isSuccess && state.trialProductsResponse != null) {
              final subCategories = state.trialProductsResponse!.subCategories;
              final trialProducts = state.trialProductsResponse!.trialProducts;

              if (trialProducts.isEmpty && _currentPage == 1) {
                return const Center(child: Text("No trial products found."));
              }

              return Column(
                children: [
                  // Subcategories Section
                  if (subCategories.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: subCategories.length,
                          itemBuilder: (context, index) {
                            final category = subCategories[index];
                            return SubCategoryCard(
                              subCategoryId: category.id,
                              subCategoryName: category.name,
                              onSubCategoryClicked: () {
                                context.pushNamed(
                                  'trialProductListPageWithCategory',
                                  pathParameters: {
                                    'categoryId': category.id,
                                    'categoryName': category.name,
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                  // Trial Product List Section
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: trialProducts.length +
                          (
                              state.trialProductsResponse!.pagination.currentPage <
                                  state.trialProductsResponse!.pagination.totalPages
                                  ? 1
                                  : 0
                          ),
                      itemBuilder: (context, index) {
                        if (index < trialProducts.length) {
                          final trialProduct = trialProducts[index];

                          return TrialProductCard(
                            trialProduct: trialProduct,
                            onTrialNowClicked: () async {
                              if(await isSubscribed()){
                                if(mounted){
                                  context.pushNamed(
                                    'trialProductDetailsPage',
                                    pathParameters: {'productId': trialProduct.id},
                                  );
                                }
                              }
                              else{
                                if(mounted){
                                  context.pushNamed("subscriptionPromotionPage");
                                }
                              }
                            },
                          );
                        } else {
                          return state.isLoading
                              ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          )
                              : const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("No trial products found."));
          },
        ),
      ),
    );
  }
}