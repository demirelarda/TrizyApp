import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:trizy_app/bloc/cart/operations/cart_operation_bloc.dart';
import 'package:trizy_app/bloc/cart/operations/cart_operation_event.dart';
import 'package:trizy_app/bloc/cart/operations/cart_operation_state.dart';
import 'package:trizy_app/bloc/product/single_product_bloc.dart';
import 'package:trizy_app/bloc/product/single_product_event.dart';
import 'package:trizy_app/bloc/product/single_product_state.dart';
import 'package:trizy_app/components/app_bar_with_icons.dart';
import 'package:trizy_app/components/bottom_bar_with_cart_button.dart';
import 'package:trizy_app/components/product_description_text.dart';
import 'package:trizy_app/components/product_rating_stars.dart';
import 'package:trizy_app/components/product_tag_chip_card.dart';
import 'package:trizy_app/models/cart/request/add_item_to_cart_request.dart';
import 'package:trizy_app/models/product/product_model.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  final String? reason;

  const ProductDetailsPage({super.key, required this.productId, this.reason});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late SingleProductBloc _productBloc;
  late CartOperationBloc _cartOperationBloc;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _productBloc = SingleProductBloc();
    _productBloc.add(SingleProductRequested(productId: widget.productId));
    _cartOperationBloc = CartOperationBloc();
  }

  @override
  void dispose() {
    _productBloc.close();
    _cartOperationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        context.pop("back");
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _productBloc),
          BlocProvider.value(value: _cartOperationBloc),
        ],
        child: BlocBuilder<SingleProductBloc, SingleProductState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Scaffold(
                backgroundColor: white,
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (state.isFailure) {
              return Scaffold(
                backgroundColor: white,
                appBar: AppBarWithIcons(
                  onBackClicked: () => context.pop("back"),
                  //onHeartClicked: () {},
                  onCartClicked: () {},
                ),
                body: Center(
                  child: Text(
                    "Failed to load product. ${state.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else if (state.isSuccess && state.productResponse != null) {
              final Product product = state.productResponse!.product;

              return Scaffold(
                backgroundColor: white,
                appBar: AppBarWithIcons(
                  onBackClicked: () => context.pop("back"),
                  //onHeartClicked: () {},
                  onCartClicked: () {
                    context.pushNamed('cart');
                  },
                ),
                bottomNavigationBar: BlocBuilder<SingleProductBloc, SingleProductState>(
                  builder: (context, singleProductState) {
                    if (!singleProductState.isSuccess || singleProductState.productResponse == null) {
                      return const SizedBox.shrink();
                    }

                    final product = singleProductState.productResponse!.product;

                    return BlocBuilder<CartOperationBloc, CartOperationState>(
                      builder: (context, cartState) {
                        final isLoading = cartState.isLoading && cartState.currentProductId == product.id;
                        final isInCart = singleProductState.isItemInCart || cartState.isSuccess;
                        final buttonText = isInCart ? "Go to Cart" : "Add to Cart";

                        return BottomBarWithCartButton(
                          price: product.price,
                          onAddToCart: () {
                            if (isInCart) {
                              context.pushNamed('cart');
                            } else {
                              _cartOperationBloc.add(
                                AddItemEvent(
                                  request: AddItemToCartRequest(
                                    productId: product.id,
                                    quantity: 1,
                                  ),
                                ),
                              );
                            }
                          },
                          isAddToCartActive: product.stockCount > 0,
                          isLoading: isLoading,
                          buttonText: buttonText,
                          cargoWeight: product.cargoWeight,
                          salePrice: product.salePrice
                        );
                      },
                    );
                  },
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.imageURLs.isNotEmpty) ...[
                          CarouselSlider.builder(
                            itemCount: product.imageURLs.length,
                            itemBuilder: (context, index, realIndex) {
                              final imageUrl = product.imageURLs[index];
                              return Container(
                                color: Colors.white,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.contain,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 300,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              reverse: false,
                              enableInfiniteScroll: false,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: DotsIndicator(
                              dotsCount: product.imageURLs.length,
                              position: _currentIndex,
                              decorator: DotsDecorator(
                                size: const Size.square(9.0),
                                activeSize: const Size(18.0, 9.0),
                                activeColor: primaryLightColor,
                                color: Colors.grey.shade400,
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: widget.reason == null
                              ? SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product.tags.length > 3 ? 3 : product.tags.length,
                              itemBuilder: (context, index) {
                                final tag = product.tags[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 0 ? 0.0 : 4.0,
                                    right: index == 2 || index == product.tags.length - 1
                                        ? 0.0
                                        : 4.0,
                                  ),
                                  child: ProductTagChipCard(text: tag),
                                );
                              },
                            ),
                          )
                              : Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              border: const GradientBoxBorder(
                                gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.reason!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed("productReviewsPage", pathParameters: {'productId': product.id});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: primaryLightColor, width: 1),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${product.averageRating}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      ProductRatingStars(rating: product.averageRating),
                                      const SizedBox(width: 8),
                                      Text(
                                        "| ${product.reviewCount} Reviews",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ProductDescriptionText(
                            text: product.description,
                            onSeeMoreClicked: () {
                              print("See more clicked");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Scaffold(
              body: Center(child: Text("No product found.")),
            );
          },
        ),
      ),
    );
  }
}