import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/subscription/subscription_bloc.dart';
import 'package:trizy_app/bloc/subscription/subscription_event.dart';
import 'package:trizy_app/bloc/subscription/subscription_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import '../../components/subscription/subscription_card.dart';

class MySubscriptionPage extends StatefulWidget {
  const MySubscriptionPage({super.key});

  @override
  State<MySubscriptionPage> createState() => _MySubscriptionPageState();
}

class _MySubscriptionPageState extends State<MySubscriptionPage> {
  late SubscriptionBloc _subscriptionBloc;

  @override
  void initState() {
    super.initState();
    _subscriptionBloc = SubscriptionBloc();
    _subscriptionBloc.add(const GetSubscriptionStatusEvent());
  }

  @override
  void dispose() {
    _subscriptionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _subscriptionBloc),
      ],
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBarWithBackButton(
          onBackClicked: () {
            context.pop();
          },
          title: "My Subscription",
        ),
        body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              if (state.errorMessage != null && state.errorMessage!.contains('404')) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "You are not subscribed to Trizy Pro!",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButton(
                          text: "Subscribe Now",
                          textColor: Colors.white,
                          color: primaryLightColor,
                          onClick: () {
                            context.pushNamed('subscriptionPromotionPage');
                          },
                        ),
                    )
                  ],
                );
              }

              return Center(
                child: Text(
                  state.errorMessage ?? "Something went wrong!",
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state.subscription != null) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: SubscriptionCard(
                  subscription: state.subscription!,
                  onCancelSubscriptionClicked: () {
                    _subscriptionBloc.add(CancelSubscriptionEvent(subscriptionId: state.subscription!.id));
                  },
                  onRenewSubscriptionClicked: () {
                    context.pushNamed('subscriptionPromotionPage');
                  },
                ),
              );
            }

            return const Center(
              child: Text(
                "No subscription data available.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}