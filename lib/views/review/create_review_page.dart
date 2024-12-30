import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trizy_app/bloc/review/operations/review_operation_bloc.dart';
import 'package:trizy_app/bloc/review/operations/review_operation_event.dart';
import 'package:trizy_app/bloc/review/operations/review_operation_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/components/review/review_product_card.dart';
import 'package:trizy_app/models/review/create_review_request.dart';
import 'package:trizy_app/theme/colors.dart';

class CreateReviewPage extends StatefulWidget {
  final String productId;
  final String productTitle;
  final String productImageUrl;
  final String orderId;

  const CreateReviewPage({
    super.key,
    required this.productId,
    required this.orderId,
    required this.productTitle,
    required this.productImageUrl,
  });

  @override
  State<CreateReviewPage> createState() => _CreateReviewPageState();
}

class _CreateReviewPageState extends State<CreateReviewPage> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();
  final int _maxCharacters = 1500;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewOperationBloc>(
      create: (_) => ReviewOperationBloc(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () {
            context.pop();
          },
          title: "Leave a Review",
        ),
        body: BlocListener<ReviewOperationBloc, ReviewOperationState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.goNamed("reviewSuccessPage");
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReviewProductCard(
                    productId: widget.productId,
                    productImageUrl: widget.productImageUrl,
                    productTitle: widget.productTitle,
                    onCardClick: () {
                      context.pushNamed(
                        'productDetailsPage',
                        pathParameters: {'productId': widget.productId},
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Pick Your Rating",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    glow: true,
                    glowColor: primaryLightColor.withOpacity(0.5),
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: primaryLightColor,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "Write Your Review (Optional)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextField(
                    controller: _reviewController,
                    maxLength: _maxCharacters,
                    cursorColor: primaryLightColor,
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: primaryLightColor,
                          width: 2.0,
                        ),
                      ),
                      hintText: "Type your review here...",
                      alignLabelWithHint: true,
                      counterText:
                      "${_reviewController.text.length} / $_maxCharacters",
                      counterStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 32),

                  BlocBuilder<ReviewOperationBloc, ReviewOperationState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: "Post Your Review",
                        textColor: white,
                        color: primaryLightColor,
                        isLoading: state.isLoading,
                        onClick: () {
                          if (_rating <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please pick a star rating first."),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          final reviewRequest = CreateReviewRequest(
                            orderId: widget.orderId,
                            productId: widget.productId,
                            rating: _rating,
                            comment: _reviewController.text,
                          );

                          context
                              .read<ReviewOperationBloc>()
                              .add(CreateReviewEvent(request: reviewRequest));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}