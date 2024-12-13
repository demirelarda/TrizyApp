import 'package:flutter/material.dart';
import '../../../components/textfields/non_editable_field.dart';
import '../../../theme/colors.dart';

class CustomHomeAppBar extends StatelessWidget {
  final VoidCallback onSearchTap;

  const CustomHomeAppBar({
    super.key,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: const BoxDecoration(
        color: primaryLightColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: NonEditableField(
        placeholder: "Search anything...",
        icon: Icons.search,
        onTap: onSearchTap,
      ),
    );
  }
}