import 'package:flutter/material.dart';
import 'package:trizy_app/theme/colors.dart';

class HorizontalScrollWidget extends StatefulWidget {
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
  State<HorizontalScrollWidget> createState() => _HorizontalScrollWidgetState();
}

class _HorizontalScrollWidgetState extends State<HorizontalScrollWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: widget.backgroundColor,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final isTwoItems = widget.items.length == 2;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onItemTap(item['id']);
            },
            child: Container(
              width: isTwoItems ? screenWidth / 2 : null,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                style: TextStyle(
                  color: selectedIndex == index
                      ? white
                      : white.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                child: Text(item['name'], textAlign: TextAlign.center),
              ),
            ),
          );
        },
      ),
    );
  }
}