import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_bloc.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_event.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_state.dart';
import 'package:trizy_app/components/product_card.dart';

class AiSuggestionsSection extends StatefulWidget {
  const AiSuggestionsSection({super.key});

  @override
  State<AiSuggestionsSection> createState() => _AiSuggestionsSectionState();
}

class _AiSuggestionsSectionState extends State<AiSuggestionsSection> {
  late AiSuggestionsBloc _aiSuggestionsBloc;

  @override
  void initState() {
    super.initState();
    _aiSuggestionsBloc = AiSuggestionsBloc()..add(const AiSuggestionsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _aiSuggestionsBloc,
      child: BlocBuilder<AiSuggestionsBloc, AiSuggestionsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: Lottie.asset(
                'assets/animations/ailoading.json',
                width: 200,
                height: 200,
              ),
            );
          } else if (state.isFailure) {
            return Center(
              child: Text(
                'Failed to load AI suggestions: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          } else if (state.isSuccess && state.productsResponse?.products.isNotEmpty == true) {
            final products = state.productsResponse!.products;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ProductCard(
                    product: product,
                    onAddToCart: () {
                      print('Add to Cart: ${product.title}');
                    },
                    onLikeTap: () {
                      print('Liked: ${product.title}');
                    },
                    onProductClicked: (productId) {
                      context.pushNamed(
                        "productDetailsPageAI",
                        pathParameters: {
                          "productId":productId,
                          "reason":product.reason ?? ""
                        }
                      );
                    },
                    isLiked: false,
                    isLoading: false,
                    productInCart: false,
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No AI suggestions available.'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _aiSuggestionsBloc.close();
    super.dispose();
  }
}