import 'package:flutter/material.dart';

class TrialPage extends StatefulWidget {
  const TrialPage({super.key});

  @override
  State<TrialPage> createState() => _TrialPageState();
}

class _TrialPageState extends State<TrialPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
              child: Column(
                children: [
                  Text("Trial Page"),
                ],
              )
          ),
          Spacer()
        ],
      ),
    );
  }
}
