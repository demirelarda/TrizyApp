import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class TopBarWithSearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onBackClicked;
  final ValueChanged<String> onSearchCompleted;
  final FocusNode? focusNode;
  final String text;

  const TopBarWithSearchField({
    super.key,
    required this.controller,
    required this.onBackClicked,
    required this.onSearchCompleted,
    this.text = "Search anything...",
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryLightColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8.0,
        bottom: 8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onBackClicked,
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: gray,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        onSubmitted: onSearchCompleted,
                        cursorColor: primaryLightColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: text,
                          hintStyle: const TextStyle(
                            color: gray,
                            fontSize: 16,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
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