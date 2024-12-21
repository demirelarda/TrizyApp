import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/products/products_bloc.dart';
import 'package:trizy_app/bloc/products/products_event.dart';
import 'package:trizy_app/bloc/products/products_state.dart';
import '../../bloc/cart/operations/feed/add_cart_item_on_feed_bloc.dart';
import '../../bloc/cart/operations/feed/add_cart_item_on_feed_event.dart';
import '../../bloc/cart/operations/feed/add_cart_item_on_feed_state.dart';
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
  // bloc for loading products
  late ProductsBloc _productsBloc;

  // bloc for "Add to Cart" from the feed
  late AddCartItemOnFeedBloc _addCartItemOnFeedBloc;

  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  // Track which product ID is currently showing a loading bar
  String? _loadingProductId;

  // Track which products have been successfully added to cart
  final Set<String> _productsInCart = {}; // TODO: WHEN FETCHING PRODUCTS GET THE PRODUCTS IN CART TO MARK THEM IN CART BEFOREHANDS

  @override
  void initState() {
    super.initState();

    _productsBloc = ProductsBloc();
    _fetchProducts();

    _addCartItemOnFeedBloc = AddCartItemOnFeedBloc();

    _scrollController.addListener(() {
      final atBottom =
          _scrollController.position.pixels == _scrollController.position.maxScrollExtent;

      final canLoadMore = !_productsBloc.state.isLoading &&
          _productsBloc.state.productsResponse?.pagination.currentPage !=
              _productsBloc.state.productsResponse?.pagination.totalPages;

      if (atBottom && canLoadMore) {
        _currentPage++;
        _fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    _productsBloc.close();
    _addCartItemOnFeedBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchProducts() {
    _productsBloc.add(
      ProductsRequested(
        categoryId: widget.categoryId,
        query: widget.query,
        page: _currentPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _productsBloc),
        BlocProvider.value(value: _addCartItemOnFeedBloc),
      ],
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          title: widget.categoryName ??
              (widget.query != null ? '"${widget.query}"' : ''),
          onBackClicked: () => context.pop(),
        ),

        body: BlocListener<AddCartItemOnFeedBloc, AddCartItemOnFeedState>(
          listener: (context, addCartState) {
            if (addCartState.isLoading) {
              setState(() {
                _loadingProductId = addCartState.currentProductId;
              });
            }

            if (addCartState.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${addCartState.errorMessage}'),
                  backgroundColor: Colors.red,
                ),
              );
              setState(() {
                _loadingProductId = null;
              });
            }

            if (addCartState.isSuccess && addCartState.response != null) {
              final productId = addCartState.currentProductId;
              if (productId != null) {
                setState(() {
                  _productsInCart.add(productId);
                  _loadingProductId = null;
                });
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(addCartState.response!.message),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },

          child: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state.isLoading && _currentPage == 1) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.isFailure) {
                return Center(
                  child: Text(
                    "Failed to load products. ${state.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state.isSuccess && state.productsResponse != null) {
                final subCategories = state.productsResponse!.subCategories;
                final products = state.productsResponse!.products;

                if (products.isEmpty && _currentPage == 1) {
                  return const Center(child: Text("No products found."));
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
                            (
                                state.productsResponse!.pagination.currentPage <
                                    state.productsResponse!.pagination.totalPages
                                    ? 1
                                    : 0
                            ),
                        itemBuilder: (context, index) {
                          if (index < products.length) {
                            final product = products[index];

                            return ProductCard(
                              product: product,
                              onProductClicked: (id) {
                                context.pushNamed(
                                  'productDetailsPage',
                                  pathParameters: {'productId': id},
                                );
                              },
                              onAddToCart: () {
                                // Only attempt if product not already in cart
                                if (!_productsInCart.contains(product.id)) {
                                  context
                                      .read<AddCartItemOnFeedBloc>()
                                      .add(AddFeedItemEvent(productId: product.id));
                                }
                              },
                              onLikeTap: () {
                                debugPrint("Liked product: ${product.title}");
                              },

                              // Show loading bar if this product is the one being added
                              isLoading: (_loadingProductId == product.id),

                              // If product was successfully added show "Go to cart"
                              productInCart: _productsInCart.contains(product.id),
                              isLiked: false,
                            );
                          } else {
                            // circular loading at the bottom
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}