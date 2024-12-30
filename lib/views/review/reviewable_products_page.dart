import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/review/get/reviewable/get_reviewable_products_bloc.dart';
import 'package:trizy_app/bloc/review/get/reviewable/get_reviewable_products_event.dart';
import 'package:trizy_app/bloc/review/get/reviewable/get_reviewable_products_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';

import '../../components/review/reviewable_product_card.dart';

class ReviewableProductsPage extends StatefulWidget {
  final String orderId;

  const ReviewableProductsPage({super.key, required this.orderId});

  @override
  State<ReviewableProductsPage> createState() => _ReviewableProductsPageState();
}

class _ReviewableProductsPageState extends State<ReviewableProductsPage> {
  late GetReviewableProductsBloc _reviewableProductsBloc;

  @override
  void initState() {
    super.initState();
    _reviewableProductsBloc = GetReviewableProductsBloc();
    _reviewableProductsBloc.add(ReviewableProductsRequested(orderId: widget.orderId));
  }

  @override
  void dispose() {
    _reviewableProductsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarWithBackButton(
        onBackClicked: () {
          context.pop();
        },
        title: "Products to Review",
      ),
      body: BlocProvider<GetReviewableProductsBloc>(
        create: (_) => _reviewableProductsBloc,
        child: BlocBuilder<GetReviewableProductsBloc, GetReviewableProductsState>(
          builder: (context, state) {
            if (state.isLoading) {
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

            if (state.isSuccess && state.getReviewableProductsResponse != null) {
              final products = state.getReviewableProductsResponse!.reviewableProducts;

              if (products.isEmpty) {
                return const Center(
                  child: Text(
                    "No products available for review.",
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              }

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ReviewableProductCard(
                    product: product,
                    onCardClick: () {
                      context.pushNamed(
                        'createReview',
                        pathParameters: {
                          'productId': product.id,
                          'productTitle': Uri.encodeComponent(product.title),
                          'productImageUrl': Uri.encodeComponent(product.imageURLs[0]),
                          'orderId': widget.orderId,
                        },
                      );
                    },
                  );
                },
              );
            }

            return const Center(
              child: Text("Unexpected state."),
            );
          },
        ),
      ),
    );
  }
}