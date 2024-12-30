import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/review/get/get_reviews_bloc.dart';
import 'package:trizy_app/bloc/review/get/get_reviews_event.dart';
import 'package:trizy_app/bloc/review/get/get_reviews_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/review/review_card.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../components/product_rating_stars.dart';

class ProductReviewsPage extends StatefulWidget {
  final String productId;

  const ProductReviewsPage({super.key, required this.productId});

  @override
  State<ProductReviewsPage> createState() => _ProductReviewsPageState();
}

class _ProductReviewsPageState extends State<ProductReviewsPage> {
  late GetReviewsBloc _getReviewsBloc;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _getReviewsBloc = GetReviewsBloc();
    _fetchReviews();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _fetchReviews();
      }
    });
  }

  void _fetchReviews() {
    _getReviewsBloc.add(ReviewsRequested(productId: widget.productId, page: _currentPage));
    _currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _getReviewsBloc,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () {
            context.pop();
          },
          title: "Reviews",
        ),
        body: BlocBuilder<GetReviewsBloc, GetReviewsState>(
          bloc: _getReviewsBloc,
          builder: (context, state) {
            if (state.isLoading && state.getReviewsResponse == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Failed to load reviews.",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            final reviews = state.getReviewsResponse?.reviews ?? [];
            final averageRating = state.getReviewsResponse?.averageRating ?? 0.0;
            final totalReviews = state.getReviewsResponse?.totalReviews ?? 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      ProductRatingStars(
                        rating: averageRating,
                        itemSize: 32,
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "based on $totalReviews reviews",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  indent: 16,
                  endIndent: 16,
                ),

                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: reviews.length + 1,
                    itemBuilder: (context, index) {
                      if (index == reviews.length) {
                        if (state.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }

                      final review = reviews[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
                        child: ReviewCard(review: review),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _getReviewsBloc.close();
    _scrollController.dispose();
    super.dispose();
  }
}