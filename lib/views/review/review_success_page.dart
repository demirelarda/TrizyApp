import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:trizy_app/components/buttons/outlined_text_button.dart';
import 'package:trizy_app/theme/colors.dart';

class ReviewSuccessPage extends StatelessWidget {
  const ReviewSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text("Review Submitted"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/confirmTick.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                repeat: false,
              ),
              const SizedBox(height: 20),

              const Text(
                "Your review has been posted!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              const Text(
                "Thank you for your feedback. Your review helps us and others make better decisions.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              OutlinedTextButton(
                text: "Go to home page",
                onClick: () {
                  context.go('/mainPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}