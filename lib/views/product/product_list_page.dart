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
import '../../components/filter_bottom_sheet.dart';
import '../../components/product_list_action_button.dart';
import '../../models/product/product_query_params.dart';

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
  ProductQueryParams? _currentFilters;

  @override
  void initState() {
    super.initState();

    _initializeBlocs();

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

  void _initializeBlocs() {
    _productsBloc = ProductsBloc()
      ..add(FetchLikedProductsFromLocal())
      ..add(FetchCartItemsFromLocal());

    if (widget.showFavourites) {
      _productsBloc.add(LikedProductsRequested(page: _currentPage));
    } else {
      _fetchProducts();
    }

    _addCartItemOnFeedBloc = AddCartItemOnFeedBloc();
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
        queryParams: _currentFilters,
      ),
    );
  }

  Future<void> _handlePop(BuildContext context, String id) async {
    final result = await context.pushNamed(
      "productDetailsPage",
      pathParameters: {"productId": id},
      extra: _productsBloc,
    );
    if (result == "back") {
      _productsBloc.add(FetchCartItemsFromLocal());
      setState(() {});
    }
  }

  void _showSortMenu({String? selectedItem}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("None"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentFilters = (_currentFilters ?? ProductQueryParams())
                            .copyWith(sortBy: null);
                        _currentPage = 1;
                      });
                      _fetchProducts();
                    },
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Price Ascending"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentFilters = (_currentFilters ?? ProductQueryParams())
                            .copyWith(sortBy: 'priceAsc');
                        _currentPage = 1;
                      });
                      _fetchProducts();
                    },
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Price Descending"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentFilters = (_currentFilters ?? ProductQueryParams())
                            .copyWith(sortBy: 'priceDesc');
                        _currentPage = 1;
                      });
                      _fetchProducts();
                    },
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Rating Count Descending"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentFilters = (_currentFilters ?? ProductQueryParams())
                            .copyWith(sortBy: 'ratingCountDesc');
                        _currentPage = 1;
                      });
                      _fetchProducts();
                    },
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Like Count Descending"),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _currentFilters = (_currentFilters ?? ProductQueryParams())
                            .copyWith(sortBy: 'likeCountDesc');
                        _currentPage = 1;
                      });
                      _fetchProducts();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
              final subCategories = widget.showFavourites
                  ? null
                  : state.productsResponse?.subCategories;
              final products = state.productsResponse?.products ?? [];

              return Column(
                children: [
                  if (!widget.showFavourites) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (subCategories?.length ?? 0) + 2,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return ProductListActionButton(
                                icon: Icons.filter_alt_outlined,
                                filterCount: filterCount(_currentFilters),
                                onTap: () {
                                  showFilterBottomSheet(
                                    context,
                                    initialParams: _currentFilters,
                                    onApplyClicked: (queryParams) {
                                      setState(() {
                                        _currentPage = 1;
                                        _currentFilters = queryParams;
                                      });
                                      _fetchProducts();
                                    },
                                    onResetClicked: () {
                                      setState(() {
                                        _currentPage = 1;
                                        _currentFilters = null;
                                      });
                                      _fetchProducts();
                                    },
                                  );
                                },
                              );
                            } else if (index == 1) {
                              return ProductListActionButton(
                                icon: Icons.sort,
                                text: "Sort",
                                onTap: () => _showSortMenu(selectedItem: _currentFilters?.sortBy),
                              );
                            } else {
                              final category = subCategories![index - 2];
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
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  Expanded(
                    child: state.isLoading && _currentPage == 1
                        ? const Center(child: CircularProgressIndicator())
                        : products.isEmpty
                        ? Center(
                      child: Text(widget.showFavourites
                          ? "No liked products found."
                          : "No products found."),
                    )
                        : ListView.builder(
                      controller: _scrollController,
                      itemCount: products.length +
                          (state.productsResponse?.pagination?.currentPage !=
                              state.productsResponse?.pagination?.totalPages
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if (index < products.length) {
                          final product = products[index];
                          final isLiked =
                          state.likedProductIds.contains(product.id);
                          final productInCart =
                          state.itemsInCart.contains(product.id);

                          return ProductCard(
                            product: product,
                            onProductClicked: (id) {
                              _handlePop(context, id);
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
                                _productsBloc
                                    .add(RemoveLikeEvent(productId: product.id));
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
            },
          ),
        ),
      ),
    );
  }
}


int filterCount(ProductQueryParams? queryParams) {
  if (queryParams == null) {
    return 0;
  }

  int count = 0;

  if (queryParams.minPrice != null) count++;
  if (queryParams.maxPrice != null) count++;
  if (queryParams.minRatingCount != null) count++;
  if (queryParams.maxRatingCount != null) count++;
  if (queryParams.minLikeCount != null) count++;
  if (queryParams.maxLikeCount != null) count++;
  if (queryParams.exactRatings != null && queryParams.exactRatings!.isNotEmpty) count++;

  return count;
}

void showFilterBottomSheet(BuildContext context, {ProductQueryParams? initialParams, required Function(ProductQueryParams) onApplyClicked, required VoidCallback onResetClicked,}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.0),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterBottomSheet(
          initialParams: initialParams,
          onApplyClicked: (queryParams) {
            onApplyClicked(queryParams);
          },
          onResetClicked: () {
            onResetClicked();
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}