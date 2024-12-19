import 'category.dart';

class CategoriesResponse {
  final bool success;
  final List<Category> categories;

  CategoriesResponse({
    required this.success,
    required this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      success: json['success'],
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}