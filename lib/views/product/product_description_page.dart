import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductDescriptionPage extends StatelessWidget {
  final String description;
  final String title;

  const ProductDescriptionPage({super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarWithBackButton(
        onBackClicked: () {
          context.pop();
        },
        title: title,
      ),
      body:
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}