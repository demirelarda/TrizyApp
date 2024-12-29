import '../product/product_category.dart';

class TrialProductsResponse {
  final bool success;
  final List<TrialProduct> trialProducts;
  final Pagination pagination;
  final List<ProductCategory> subCategories;
  final bool hasActiveTrial;

  TrialProductsResponse({
    required this.success,
    required this.trialProducts,
    required this.pagination,
    this.subCategories = const [],
    this.hasActiveTrial = false,
  });

  factory TrialProductsResponse.fromJson(Map<String, dynamic> json) {
    return TrialProductsResponse(
      success: json['success'],
      trialProducts: (json['trialProducts'] as List)
          .map((item) => TrialProduct.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
          .map((item) => ProductCategory.fromJson(item))
          .toList()
          : [],
      hasActiveTrial: json['hasActiveTrial'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'trialProducts': trialProducts.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
      'subCategories': subCategories.map((e) => e.toJson()).toList(),
      'hasActiveTrial': hasActiveTrial,
    };
  }
}

class TrialProduct {
  final String id;
  final String title;
  final String description;
  final int trialPeriod;
  final int availableCount;
  final String category;
  final List<String> imageURLs;

  TrialProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.trialPeriod,
    required this.availableCount,
    required this.category,
    required this.imageURLs,
  });

  factory TrialProduct.fromJson(Map<String, dynamic> json) {
    return TrialProduct(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      trialPeriod: json['trialPeriod'],
      availableCount: json['availableCount'],
      category: json['category']['name'],
      imageURLs: List<String>.from(json['imageURLs']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'trialPeriod': trialPeriod,
      'availableCount': availableCount,
      'category': category,
      'imageURLs': imageURLs,
    };
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalTrialProducts;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalTrialProducts,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalTrialProducts: json['totalTrialProducts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalTrialProducts': totalTrialProducts,
    };
  }
}