import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/components/subscription/text_with_tick_icon.dart';
import 'package:trizy_app/theme/colors.dart';

class SubscriptionPromotionPage extends StatelessWidget {
  const SubscriptionPromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  white,
                  whitePinkColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Center(
            child: Image.asset(
              'assets/images/trizyprobackgroundv2.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 2 / 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Trizy Pro Subscription",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Column(
                      children: [
                        TextWithTickIcon(
                          text: "Faster delivery on all orders",
                        ),
                        SizedBox(height: 12),
                        TextWithTickIcon(
                          text: "Access to early product trials",
                        ),
                        SizedBox(height: 12),
                        TextWithTickIcon(
                          text: "Priority access to high-demand products",
                        ),
                      ],
                    ),

                    const Spacer(),

                    const Text(
                      "This is an auto-renewable subscription. You will be charged \$30/month unless canceled before the next billing cycle.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: CustomButton(
                        text: "Subscribe for \$30/Month",
                        textColor: white,
                        color: primaryLightColor,
                        onClick: () {
                          context.pushNamed("subscriptionView");
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}