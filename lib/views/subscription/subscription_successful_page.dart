import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/components/buttons/outlined_text_button.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:confetti/confetti.dart';

class SubscriptionSuccessfulPage extends StatefulWidget {
  const SubscriptionSuccessfulPage({super.key});

  @override
  State<SubscriptionSuccessfulPage> createState() =>
      _SubscriptionSuccessfulPageState();
}

class _SubscriptionSuccessfulPageState
    extends State<SubscriptionSuccessfulPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text("Subscription Successful"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange],
              numberOfParticles: 30,
              gravity: 0.3,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/trizyprologo.png',
                    width: 200,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Welcome to Trizy Pro!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}