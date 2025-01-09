import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/trial/single/single_trial_product_bloc.dart';
import 'package:trizy_app/bloc/trial/single/single_trial_product_event.dart';
import 'package:trizy_app/bloc/trial/single/single_trial_product_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/product_description_text.dart';
//import 'package:trizy_app/components/product_rating_stars.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../components/buttons/custom_button.dart';
import '../../models/trialproduct/trial_products_response.dart';
import '../../utils/active_trial_check.dart';

class TrialProductDetailsPage extends StatefulWidget {
  final String trialProductId;

  const TrialProductDetailsPage({super.key, required this.trialProductId});

  @override
  State<TrialProductDetailsPage> createState() =>
      _TrialProductDetailsPageState();
}

class _TrialProductDetailsPageState extends State<TrialProductDetailsPage> {
  late SingleTrialProductBloc _trialProductBloc;
  int _currentIndex = 0;
  bool _hasActiveTrial = false;

  @override
  void initState() {
    super.initState();
    _trialProductBloc = SingleTrialProductBloc();
    _trialProductBloc.add(SingleTrialProductRequested(
      trialProductId: widget.trialProductId,
    ));
    _checkHasActiveTrial();
  }

  Future<void> _checkHasActiveTrial() async {
    final hasActiveTrial = await checkHasActiveTrial();
    setState(() {
      _hasActiveTrial = hasActiveTrial;
    });
  }

  @override
  void dispose() {
    _trialProductBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _trialProductBloc,
      child: BlocBuilder<SingleTrialProductBloc, SingleTrialProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              backgroundColor: white,
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state.isFailure) {
            return Scaffold(
              backgroundColor: white,
              appBar: AppBarWithBackButton(
                onBackClicked: () {
                  context.pop();
                },
              ),
              body: Center(
                child: Text(
                  "Failed to load trial product. ${state.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (state.isSuccess &&
              state.singleTrialProductResponse != null) {
            final TrialProduct trialProduct =
                state.singleTrialProductResponse!.trialProduct;

            return Scaffold(
              backgroundColor: white,
              appBar: AppBarWithBackButton(
                onBackClicked: () {
                  context.pop();
                },
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 32, top: 16),
                child: CustomButton(
                  text: "See Trial Details",
                  textColor: Colors.white,
                  color: primaryLightColor,
                  onClick: () {
                    context.pushNamed(
                      "trialDetails",
                      pathParameters: {
                        'trialProductId': trialProduct.id,
                        'trialProductName': trialProduct.title,
                        'trialProductImageUrl': trialProduct.imageURLs.first,
                        'trialPeriod': trialProduct.trialPeriod.toString(),
                      },
                    );
                  },
                  height: 56,
                  width: double.infinity,
                  disabled: _hasActiveTrial, // Disable if user has active trial
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Slider
                      if (trialProduct.imageURLs.isNotEmpty) ...[
                        CarouselSlider.builder(
                          itemCount: trialProduct.imageURLs.length,
                          itemBuilder: (context, index, realIndex) {
                            final imageUrl = trialProduct.imageURLs[index];
                            return Container(
                              color: Colors.white,
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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

                        // Dot Indicator
                        Center(
                          child: DotsIndicator(
                            dotsCount: trialProduct.imageURLs.length,
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

                      // Product Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          trialProduct.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Rating Section
                      /*
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: primaryLightColor, width: 1),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  ProductRatingStars(rating: 3.5),
                                  SizedBox(width: 8),
                                  Text(
                                    "| 120 Reviews",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                       */

                      const SizedBox(height: 16),

                      // Description Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ProductDescriptionText(
                          text: trialProduct.description,
                          onSeeMoreClicked: () {
                            context.pushNamed(
                                "productDescriptionPage",
                                pathParameters: {
                                  "title":trialProduct.title,
                                  "description":trialProduct.description
                                }
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Availability and Trial Period
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              trialProduct.availableCount > 0
                                  ? "Available"
                                  : "Not Available",
                              style: TextStyle(
                                fontSize: 16,
                                color: trialProduct.availableCount > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            if (trialProduct.availableCount > 0)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${trialProduct.trialPeriod} days",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const Scaffold(
            body: Center(child: Text("No trial product found.")),
          );
        },
      ),
    );
  }
}