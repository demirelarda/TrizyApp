import 'package:trizy_app/models/product/product_model.dart';
import 'product_category.dart';

class ProductsResponse {
  final bool success;
  final List<Product> products;
  final Pagination? pagination;
  final List<ProductCategory> subCategories;

  ProductsResponse({
    required this.success,
    required this.products,
    this.pagination,
    this.subCategories = const [],
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      success: json['success'],
      products: (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
          .map((category) => ProductCategory.fromJson(category))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'products': products.map((product) => product.toJson()).toList(),
      'pagination': pagination?.toJson(),
      'subCategories': subCategories.map((category) => category.toJson()).toList(),
    };
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalProducts;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalProducts,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalProducts: json['totalProducts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalProducts': totalProducts,
    };
  }
}