import 'package:flutter/material.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/models/product/product_query_params.dart';
import 'package:trizy_app/theme/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(ProductQueryParams) onApplyClicked;
  final VoidCallback onResetClicked;
  final ProductQueryParams? initialParams;

  const FilterBottomSheet({
    super.key,
    required this.onApplyClicked,
    required this.onResetClicked,
    this.initialParams,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController minRatingCountController = TextEditingController();
  final TextEditingController maxRatingCountController = TextEditingController();
  final TextEditingController minLikeCountController = TextEditingController();
  final TextEditingController maxLikeCountController = TextEditingController();

  List<int> selectedRatings = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialParams != null) {
      final params = widget.initialParams!;
      if (params.minPrice != null) {
        minPriceController.text = params.minPrice!.toString();
      }
      if (params.maxPrice != null) {
        maxPriceController.text = params.maxPrice!.toString();
      }
      if (params.minRatingCount != null) {
        minRatingCountController.text = params.minRatingCount!.toString();
      }
      if (params.maxRatingCount != null) {
        maxRatingCountController.text = params.maxRatingCount!.toString();
      }
      if (params.minLikeCount != null) {
        minLikeCountController.text = params.minLikeCount!.toString();
      }
      if (params.maxLikeCount != null) {
        maxLikeCountController.text = params.maxLikeCount!.toString();
      }
      if (params.exactRatings != null) {
        selectedRatings = List.from(params.exactRatings!);
      }
    }
  }

  void _toggleRating(int rating) {
    setState(() {
      if (selectedRatings.contains(rating)) {
        selectedRatings.remove(rating);
      } else {
        selectedRatings.add(rating);
      }
    });
  }

  InputDecoration _buildInputDecoration(String hintText, {String? prefixText}) {
    return InputDecoration(
      prefixText: prefixText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: primaryLightColor, width: 2.0),
      ),
      hintText: hintText,
    );
  }

  void _onApply() {
    final ProductQueryParams queryParams = ProductQueryParams(
      minPrice: minPriceController.text.isNotEmpty ? double.tryParse(minPriceController.text) : null,
      maxPrice: maxPriceController.text.isNotEmpty ? double.tryParse(maxPriceController.text) : null,
      minRatingCount: minRatingCountController.text.isNotEmpty ? int.tryParse(minRatingCountController.text) : null,
      maxRatingCount: maxRatingCountController.text.isNotEmpty ? int.tryParse(maxRatingCountController.text) : null,
      minLikeCount: minLikeCountController.text.isNotEmpty ? int.tryParse(minLikeCountController.text) : null,
      maxLikeCount: maxLikeCountController.text.isNotEmpty ? int.tryParse(maxLikeCountController.text) : null,
      exactRatings: selectedRatings.isNotEmpty ? selectedRatings : null,
    );

    widget.onApplyClicked(queryParams);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filter",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onResetClicked,
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryLightColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Price",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minPriceController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Min", prefixText: "\$"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("to"),
                ),
                Expanded(
                  child: TextField(
                    controller: maxPriceController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Max", prefixText: "\$"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Rating",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final rating = index + 1;
                final isSelected = selectedRatings.contains(rating);
                return GestureDetector(
                  onTap: () => _toggleRating(rating),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryLightColor : Colors.white,
                      border: Border.all(
                        color: isSelected ? primaryLightColor : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.star,
                          color: isSelected ? Colors.white : Colors.amber,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),

            const Text(
              "Rating Count",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minRatingCountController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Min"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("to"),
                ),
                Expanded(
                  child: TextField(
                    controller: maxRatingCountController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Max"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              "Like Count",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minLikeCountController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Min"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("to"),
                ),
                Expanded(
                  child: TextField(
                    controller: maxLikeCountController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration("Max"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: "Apply",
              textColor: Colors.white,
              color: primaryLightColor,
              onClick: _onApply,
            ),
          ],
        ),
      ),
    );
  }
}