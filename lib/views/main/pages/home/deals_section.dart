import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../bloc/deals/deals_bloc.dart';
import '../../../../bloc/deals/deals_event.dart';
import '../../../../bloc/deals/deals_state.dart';
import '../../../../components/deal_holder_card.dart';
import '../../../../components/home_page_action_widget.dart';
import '../../../../components/home_page_chip_card.dart';
import '../../../../utils/auth_check.dart';
import '../../../../utils/sub_check.dart';

class DealsSection extends StatefulWidget {
  const DealsSection({super.key});

  @override
  State<DealsSection> createState() => _DealsSectionState();
}

class _DealsSectionState extends State<DealsSection> {
  String _title = "";
  String _description = "";
  VoidCallback? _onTap;

  @override
  void initState() {
    super.initState();
    _initializeHomePageAction();
  }

  Future<void> _initializeHomePageAction() async {
    final isUserAuthenticated = await isAuthenticated();
    if (!isUserAuthenticated) {
      // User is not authenticated
      setState(() {
        _title = "Hello there!";
        _description = "Let's signup to see Trizy's advantages!";
        _onTap = () => context.goNamed("signup");
      });
    } else {
      // User is authenticated
      final isUserSubscribed = await isSubscribed();
      final user = await getUser();
      final firstName = user?.firstName ?? "there";

      if (!isUserSubscribed) {
        // User is not subscribed
        setState(() {
          _title = "Hello, $firstName";
          _description = "Subscribe to Trizy Pro to get full advantages!";
          _onTap = () => context.pushNamed("subscriptionPromotionPage");
        });
      } else {
        // User is subscribed
        setState(() {
          _title = "Hello, $firstName";
          _description = "How does Trizy Plus privilege feel?";
          _onTap = () => context.pushNamed("mySubscription");
        });
      }
    }
  }

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
                          onTap: () async {
                            if(mounted){
                              if(await isAuthenticated()){
                                context.pushNamed("myOrdersFromHome");
                              }
                              else{
                                context.goNamed("signup");
                              }
                            }
                          },
                        ),
                        const SizedBox(width: 8.0),
                        HomePageChipCard(
                          icon: Icons.receipt_long,
                          label: "My Last Order",
                          onTap: () async {
                            if(mounted){
                              if(await isAuthenticated()){
                                context.pushNamed("myLastOrder");
                            }
                            else{
                              context.goNamed("signup");
                            }
                          }
                          },
                        ),
                        const SizedBox(width: 8.0),
                        HomePageChipCard(
                          icon: Icons.favorite,
                          label: "Favourite Products",
                          onTap: () async {
                            if(mounted){
                              if(await isAuthenticated()){
                                context.pushNamed("favouriteProducts");
                            }
                            else{
                              context.goNamed("signup");
                            }
                          }
                          },
                        ),
                        const SizedBox(width: 8.0),
                        HomePageChipCard(
                          icon: Icons.person,
                          label: "My Profile",
                          onTap: () async {
                            if(mounted){
                              if(await isAuthenticated()){
                            context.pushNamed("myProfilePage");
                            }
                            else{
                            context.goNamed("signup");
                            }
                          }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  HomePageActionWidget(
                    title: _title,
                    description: _description,
                    onTap: _onTap ?? () {},
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
                                handleDealAction(context: context, action: deal.action, title: deal.title);
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

void handleDealAction({required BuildContext context, required String action, required String title}) {
  if (action.startsWith("category:")) {
    final categoryId = action.split(":")[1];
    context.pushNamed(
      "productListPageWithCategory",
      pathParameters: {
        "categoryId": categoryId,
        "categoryName": title,
      },
    );
  } else if (action.startsWith("query:")) {
    final query = action.split(":")[1];
    context.pushNamed(
      "productListPageWithQuery",
      queryParameters: {
        "query": query,
      },
    );
  } else if (action.startsWith("productDetails:")) {
    final productId = action.split(":")[1];
    context.pushNamed(
      "productDetailsPage",
      pathParameters: {
        "productId": productId,
      },
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Invalid action!")),
    );
  }
}