import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/products/products_bloc.dart';
import 'package:trizy_app/bloc/products/products_event.dart';
import 'package:trizy_app/bloc/products/products_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/product_card.dart';
import 'package:trizy_app/components/sub_category_card.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductListPage extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;
  final String? query;

  const ProductListPage({
    super.key,
    this.categoryId,
    this.categoryName,
    this.query,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductsBloc productsBloc;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    productsBloc = ProductsBloc();
    _fetchProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !productsBloc.state.isLoading &&
          productsBloc.state.productsResponse?.pagination.currentPage !=
              productsBloc.state.productsResponse?.pagination.totalPages) {
        currentPage++;
        _fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    productsBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchProducts() {
    productsBloc.add(
      ProductsRequested(
        categoryId: widget.categoryId,
        query: widget.query,
        page: currentPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: productsBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          title: widget.categoryName ?? (widget.query != null ? '"${widget.query}"' : ''),
          onBackClicked: () => context.pop(),
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state.isLoading && currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isFailure) {
              return Center(
                child: Text(
                  "Failed to load products. ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state.isSuccess && state.productsResponse != null) {
              final subCategories = state.productsResponse!.subCategories;
              final products = state.productsResponse!.products;

              if (products.isEmpty && currentPage == 1) {
                return const Center(
                  child: Text("No products found."),
                );
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
                                  'productListPageWithCategory',
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


                  // Product List Section
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: products.length +
                          (state.productsResponse!.pagination.currentPage <
                              state.productsResponse!.pagination.totalPages
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if (index < products.length) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onProductClicked: (id){
                              context.pushNamed(
                                'productDetailsPage',
                                pathParameters: {
                                  'productId': id
                                },
                              );
                            },
                            onAddToCart: () {
                              print("Added to cart: ${product.title}");
                            },
                            onLikeTap: () {
                              print("Liked product: ${product.title}");
                            },
                            isLiked: false,
                          );
                        } else {
                          // circular loading at the bottom
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("No products found."));
          },
        ),
      ),
    );
  }
}