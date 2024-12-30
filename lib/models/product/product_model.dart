import 'package:trizy_app/models/product/product_category.dart';

class Product {
  final String id;
  final List<String> imageURLs;
  final String title;
  final String description;
  final double price;
  final int stockCount;
  final ProductCategory category;
  final List<String> tags;
  final double cargoWeight;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double averageRating;
  final int likeCount;
  final int reviewCount;

  Product({
    required this.id,
    required this.imageURLs,
    required this.title,
    required this.description,
    required this.price,
    required this.stockCount,
    required this.category,
    required this.tags,
    required this.cargoWeight,
    required this.createdAt,
    required this.updatedAt,
    this.averageRating = 0.0,
    this.likeCount = 0,
    this.reviewCount = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      imageURLs: List<String>.from(json['imageURLs']),
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stockCount: json['stockCount'],
      category: ProductCategory.fromJson(json['category']),
      tags: List<String>.from(json['tags']),
      cargoWeight: (json['cargoWeight'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      averageRating: json['averageRating'] != null
          ? (json['averageRating'] as num).toDouble()
          : 0.0,
      likeCount: json['likeCount'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageURLs': imageURLs,
      'title': title,
      'description': description,
      'price': price,
      'stockCount': stockCount,
      'category': category.toJson(),
      'tags': tags,
      'cargoWeight': cargoWeight,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'averageRating': averageRating,
      'likeCount': likeCount,
      'reviewCount': reviewCount,
    };
  }
}