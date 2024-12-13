import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class HorizontalScrollWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Color backgroundColor;
  final ValueChanged<int> onItemTap;

  const HorizontalScrollWidget({
    super.key,
    required this.items,
    required this.backgroundColor,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onItemTap(item['id']),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Text(
                  item['name'],
                  style: const TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}