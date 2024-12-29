import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';
import 'package:trizy_app/components/buttons/outlined_text_button.dart';
import 'package:trizy_app/theme/colors.dart';

class TrialSuccessPage extends StatefulWidget {
  const TrialSuccessPage({super.key});

  @override
  State<TrialSuccessPage> createState() => _TrialSuccessPageState();
}

class _TrialSuccessPageState extends State<TrialSuccessPage> {
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
    final deliveryDate = DateTime.now().add(const Duration(days: 2));

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text("Trial Successful"),
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
                  Lottie.asset(
                    'assets/animations/confirmTick.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    repeat: false,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Trial Request Successful!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Your trialed product will be delivered on ${deliveryDate.day.toString().padLeft(2, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.year}. Enjoy your trial!",
                    style: const TextStyle(
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
        ],
      ),
    );
  }
}