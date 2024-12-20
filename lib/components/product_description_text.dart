import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class ProductDescriptionText extends StatefulWidget {
  final String text;
  final VoidCallback onSeeMoreClicked;

  const ProductDescriptionText({
    super.key,
    required this.text,
    required this.onSeeMoreClicked,
  });

  @override
  State<ProductDescriptionText> createState() => _ProductDescriptionTextState();
}

class _ProductDescriptionTextState extends State<ProductDescriptionText> {
  @override
  Widget build(BuildContext context) {
    const maxCharacters = 200;
    final bool isTextOverflowing = widget.text.length > maxCharacters;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Text(
                  isTextOverflowing
                      ? '${widget.text.substring(0, maxCharacters)}...'
                      : widget.text,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                if (isTextOverflowing)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(0, 255, 255, 255),
                            Color.fromARGB(64, 255, 255, 255),
                            Color.fromARGB(128, 255, 255, 255),
                            Color.fromARGB(192, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isTextOverflowing) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: widget.onSeeMoreClicked,
                child: const Text(
                  "See all description & features",
                  style: TextStyle(
                    color: primaryLightColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}