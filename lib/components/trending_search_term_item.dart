import 'package:flutter/material.dart';

class TrendingSearchItem extends StatelessWidget {
  final String searchTerm;
  final VoidCallback onTap;

  const TrendingSearchItem({
    super.key,
    required this.searchTerm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Material(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          splashColor: Colors.grey.withOpacity(0.3),
          highlightColor: Colors.grey.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    searchTerm,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}