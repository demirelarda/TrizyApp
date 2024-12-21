import 'package:flutter/material.dart';

class CartProductControllerItems extends StatelessWidget {
  final int quantity;
  final VoidCallback onMinusClicked;
  final VoidCallback onPlusClicked;
  final VoidCallback onRemoveClicked;
  final bool isMinusLoading;
  final bool isPlusLoading;
  final bool isRemoveLoading;

  const CartProductControllerItems({
    super.key,
    required this.quantity,
    required this.onMinusClicked,
    required this.onPlusClicked,
    required this.onRemoveClicked,
    this.isMinusLoading = false,
    this.isPlusLoading = false,
    this.isRemoveLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Disable all buttons if any loading is true
    final isAnyLoading = isMinusLoading || isPlusLoading || isRemoveLoading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Minus Button
        _buildCircleButton(
          icon: Icons.remove,
          onPressed: isAnyLoading ? null : onMinusClicked,
          isLoading: isMinusLoading,
        ),
        // Quantity
        Text(
          quantity.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Plus Button
        _buildCircleButton(
          icon: Icons.add,
          onPressed: isAnyLoading ? null : onPlusClicked,
          isLoading: isPlusLoading,
        ),
        // Trash Bin Button
        _buildTrashButton(
          onPressed: isAnyLoading ? null : onRemoveClicked,
          isLoading: isRemoveLoading,
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isLoading,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              color: Colors.grey.shade600,
            ),
          )
              : Icon(
            icon,
            size: 20,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildTrashButton({
    required VoidCallback? onPressed,
    required bool isLoading,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              color: Colors.grey.shade600,
            ),
          )
              : Icon(
            Icons.delete_outline,
            size: 20,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}