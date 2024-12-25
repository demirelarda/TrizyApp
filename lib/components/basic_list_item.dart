import 'package:flutter/material.dart';

class BasicListItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BasicListItem({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}