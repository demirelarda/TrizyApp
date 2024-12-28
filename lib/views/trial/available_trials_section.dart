import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/trial/trial_products_bloc.dart';
import 'package:trizy_app/bloc/trial/trial_products_event.dart';
import 'package:trizy_app/bloc/trial/trial_products_state.dart';
import 'package:trizy_app/utils/sub_check.dart';
import '../../components/trial_product_card.dart';

class AvailableTrialsSection extends StatefulWidget {
  const AvailableTrialsSection({super.key});

  @override
  State<AvailableTrialsSection> createState() => _AvailableTrialsSectionState();
}

class _AvailableTrialsSectionState extends State<AvailableTrialsSection> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  late TrialProductsBloc _trialProductsBloc;

  @override
  void initState() {
    super.initState();

    _trialProductsBloc = TrialProductsBloc();
    _fetchTrialProducts();

    // Set up pagination with scroll listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreProducts();
      }
    });
  }

  void _fetchTrialProducts() {
    _trialProductsBloc.add(TrialProductsRequested(page: _currentPage, categoryId: null, query: null));
  }

  void _loadMoreProducts() {
    final state = _trialProductsBloc.state;
    if (!state.isLoading && state.trialProductsResponse != null) {
      final totalPages = state.trialProductsResponse!.pagination.totalPages;
      if (_currentPage < totalPages) {
        _currentPage++;
        _fetchTrialProducts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _trialProductsBloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Recent Trial Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TrialProductsBloc, TrialProductsState>(
              builder: (context, state) {
                if (state.isLoading && state.trialProductsResponse == null) {
                  // Initial Loading State
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.isFailure) {
                  // Error State
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Failed to load trial products',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state.trialProductsResponse != null) {
                  final trialProducts = state.trialProductsResponse!.trialProducts;

                  if (trialProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        "No trial products available.",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    );
                  }

                  // Success State with products
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: trialProducts.length + 1, // + 1 for loading indicator
                    padding: const EdgeInsets.only(top: 8.0),
                    itemBuilder: (context, index) {
                      if (index == trialProducts.length) {
                        // Show a loading indicator at the end
                        return state.isLoading
                            ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                            : const SizedBox.shrink();
                      }

                      final trialProduct = trialProducts[index];
                      return TrialProductCard(
                        trialProduct: trialProduct,
                        onTrialNowClicked: () async {
                          if(await isSubscribed()){
                            // go to trial page
                            if(mounted){

                            }
                          }
                          else{
                            if(mounted){
                              context.pushNamed("subscriptionPromotionPage");
                            }
                          }
                        },
                      );
                    },
                  );
                }

                return const Center(
                  child: Text("No trial products available."),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _trialProductsBloc.close();
    _scrollController.dispose();
    super.dispose();
  }
}