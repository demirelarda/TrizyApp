import 'package:flutter/material.dart';

class CustomTapWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;

  const CustomTapWrapper({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        splashColor: Colors.grey.withOpacity(0.2),
        child: child,
      ),
    );
  }
}