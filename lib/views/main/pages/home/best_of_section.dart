import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/products/bestof/best_of_products_bloc.dart';
import 'package:trizy_app/bloc/products/bestof/best_of_products_event.dart';
import 'package:trizy_app/bloc/products/bestof/best_of_products_state.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_bloc.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_event.dart';
import 'package:trizy_app/bloc/cart/operations/feed/add_cart_item_on_feed_state.dart';
import 'package:trizy_app/components/product_card.dart';
import 'package:trizy_app/theme/colors.dart';

class BestOfProductsView extends StatefulWidget {
  final String period;

  const BestOfProductsView({super.key, required this.period});

  @override
  State<BestOfProductsView> createState() => _BestOfProductsViewState();
}

class _BestOfProductsViewState extends State<BestOfProductsView> {
  late BestOfProductsBloc _bestOfProductsBloc;
  late AddCartItemOnFeedBloc _addCartItemOnFeedBloc;
  String? _loadingProductId;

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  @override
  void didUpdateWidget(covariant BestOfProductsView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.period != oldWidget.period) {
      _initializeBlocs();
    }
  }

  void _initializeBlocs() {
    _bestOfProductsBloc = BestOfProductsBloc()
      ..add(BestProductsRequested(period: widget.period))
      ..add(BestOfFetchLikedProductsFromLocal())
      ..add(BestOfFetchCartItemsFromLocal());

    _addCartItemOnFeedBloc = AddCartItemOnFeedBloc();
  }

  @override
  void dispose() {
    _bestOfProductsBloc.close();
    _addCartItemOnFeedBloc.close();
    super.dispose();
  }

  Future<void> _handleProductTap(BuildContext context, String productId) async {
    final result = await context.pushNamed(
      "productDetailsPage",
      pathParameters: {"productId": productId},
    );
    if (result == "back") {
      _bestOfProductsBloc.add(BestOfFetchCartItemsFromLocal());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _bestOfProductsBloc),
        BlocProvider.value(value: _addCartItemOnFeedBloc),
      ],
      child: BlocListener<AddCartItemOnFeedBloc, AddCartItemOnFeedState>(
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
              _bestOfProductsBloc.add(BestOfFetchCartItemsFromLocal());
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
        child: BlocBuilder<BestOfProductsBloc, BestOfProductsState>(
          builder: (context, state) {
            final products = state.productsResponse?.products ?? [];

            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                color: white,
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : products.isEmpty
                    ? const Center(
                  child: Text(
                    "No products found for this period.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isLiked = state.likedProductIds.contains(product.id);
                    final productInCart = state.itemsInCart.contains(product.id);

                    return ProductCard(
                      product: product,
                      onProductClicked: (id) {
                        _handleProductTap(context, id);
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
                          _bestOfProductsBloc.add(BestOfRemoveLikeEvent(productId: product.id));
                        } else {
                          _bestOfProductsBloc.add(BestOfAddLikeEvent(productId: product.id));
                        }
                      },
                      isLoading: (_loadingProductId == product.id),
                      productInCart: productInCart,
                      isLiked: isLiked,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}