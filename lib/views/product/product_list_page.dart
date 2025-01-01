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
  final bool showFavourites;

  const ProductListPage({
    super.key,
    this.categoryId,
    this.categoryName,
    this.query,
    this.showFavourites = false,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductsBloc _productsBloc;
  late AddCartItemOnFeedBloc _addCartItemOnFeedBloc;

  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  String? _loadingProductId;

  @override
  void initState() {
    super.initState();

    _productsBloc = ProductsBloc()
      ..add(FetchLikedProductsFromLocal())
      ..add(FetchCartItemsFromLocal());
    if (widget.showFavourites) {
      _productsBloc.add(LikedProductsRequested(page: _currentPage));
    } else {
      _productsBloc.add(ProductsRequested(
        categoryId: widget.categoryId,
        query: widget.query,
        page: _currentPage,
      ));
    }

    _addCartItemOnFeedBloc = AddCartItemOnFeedBloc();

    _scrollController.addListener(() {
      final atBottom =
          _scrollController.position.pixels == _scrollController.position.maxScrollExtent;

      final canLoadMore = !_productsBloc.state.isLoading &&
          _productsBloc.state.productsResponse?.pagination?.currentPage !=
              _productsBloc.state.productsResponse?.pagination?.totalPages;

      if (atBottom && canLoadMore) {
        _currentPage++;
        if (widget.showFavourites) {
          _productsBloc.add(LikedProductsRequested(page: _currentPage));
        } else {
          _fetchProducts();
        }
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
          title: widget.showFavourites
              ? 'Favourites'
              : widget.categoryName ?? (widget.query != null ? '"${widget.query}"' : ''),
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
                _productsBloc.add(FetchCartItemsFromLocal());
                setState(() {
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
                final subCategories = widget.showFavourites ? null : state.productsResponse!.subCategories;
                final products = state.productsResponse!.products;

                if (products.isEmpty && _currentPage == 1) {
                  return Center(
                    child: Text(widget.showFavourites
                        ? "No liked products found."
                        : "No products found."),
                  );
                }

                return Column(
                  children: [
                    if (subCategories != null && subCategories.isNotEmpty)
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
                                state.productsResponse!.pagination?.currentPage !=
                                    state.productsResponse!.pagination?.totalPages
                                    ? 1
                                    : 0),
                        itemBuilder: (context, index) {
                          if (index < products.length) {
                            final product = products[index];
                            final isLiked = state.likedProductIds.contains(product.id);
                            final productInCart = state.itemsInCart.contains(product.id);

                            return ProductCard(
                              product: product,
                              onProductClicked: (id) {
                                context.pushNamed(
                                  'productDetailsPage',
                                  pathParameters: {'productId': id},
                                );
                              },
                              onAddToCart: () {
                                if (!productInCart) {
                                  context
                                      .read<AddCartItemOnFeedBloc>()
                                      .add(AddFeedItemEvent(productId: product.id));
                                }
                              },
                              onLikeTap: () {
                                if (isLiked) {
                                  _productsBloc.add(RemoveLikeEvent(productId: product.id));
                                } else {
                                  _productsBloc.add(AddLikeEvent(productId: product.id));
                                }
                              },
                              isLoading: (_loadingProductId == product.id),
                              productInCart: productInCart,
                              isLiked: isLiked,
                            );
                          } else {
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