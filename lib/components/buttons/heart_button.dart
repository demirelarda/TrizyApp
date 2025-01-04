import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class HeartButton extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onLikeTap;

  const HeartButton({
    super.key,
    required this.isLiked,
    required this.onLikeTap,
  });

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
  }

  void _handleLikeTap() {
    setState(() {
      _isLiked = !_isLiked;
    });
    widget.onLikeTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleLikeTap,
      child: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? primaryLightColor : Colors.grey,
        size: 36,
      ),
    );
  }
}