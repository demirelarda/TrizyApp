import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bloc/deals/deals_bloc.dart';
import '../../../../bloc/deals/deals_event.dart';
import '../../../../bloc/deals/deals_state.dart';
import '../../../../components/deal_holder_card.dart';
import '../../../../components/home_page_action_widget.dart';
import '../../../../components/home_page_chip_card.dart';

class DealsSection extends StatelessWidget {
  const DealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealsBloc()..add(DealsRequested()),
      child: BlocBuilder<DealsBloc, DealsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        HomePageChipCard(
                          icon: Icons.shopping_bag,
                          label: "My Orders",
                          onTap: () {
                            print('Tapped on My Orders');
                          },
                        ),
                        const SizedBox(width: 8.0),
                        HomePageChipCard(
                          icon: Icons.receipt_long,
                          label: "My Last Order",
                          onTap: () {
                            print('Tapped on My Last Order');
                          },
                        ),
                        const SizedBox(width: 8.0),
                        HomePageChipCard(
                          icon: Icons.favorite,
                          label: "Favourite Products",
                          onTap: () {
                            print('Tapped on Favourite Products');
                          },
                        ),
                        const SizedBox(width: 8.0),
                        HomePageChipCard(
                          icon: Icons.person,
                          label: "Account",
                          onTap: () {
                            print('Tapped on Account');
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  HomePageActionWidget(
                    title: "Hello there!",
                    description: "Let's login to see trizy's advantages!",
                    onTap: () {
                      print('Action widget tapped');
                    },
                  ),

                  const SizedBox(height: 12),


                  // Deals Section
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.isFailure)
                    Center(
                      child: Text(
                        'Failed to load deals: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  else if (state.isSuccess && state.deals != null)
                      Column(
                        children: state.deals!.deals
                            .map(
                              (deal) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: DealHolderCard(
                              imageUrl: deal.imageUrl,
                              aspectRatio: deal.aspectRatioValue,
                              onTap: () {
                                print('Tapped on deal: ${deal.title}');
                              },
                            ),
                          ),
                        )
                            .toList(),
                      )
                    else
                      const Center(child: Text('No deals available.')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}