import 'package:trizy_app/models/product/product_model.dart';

class SingleProductResponse {
  final bool success;
  final Product product;

  SingleProductResponse({
    required this.success,
    required this.product,
  });

  factory SingleProductResponse.fromJson(Map<String, dynamic> json) {
    return SingleProductResponse(
      success: json['success'],
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'product': product.toJson(),
    };
  }
}