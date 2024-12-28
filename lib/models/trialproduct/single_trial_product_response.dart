class SingleTrialProductResponse {
  final bool success;
  final TrialProduct trialProduct;

  SingleTrialProductResponse({
    required this.success,
    required this.trialProduct,
  });

  factory SingleTrialProductResponse.fromJson(Map<String, dynamic> json) {
    return SingleTrialProductResponse(
      success: json['success'],
      trialProduct: TrialProduct.fromJson(json['trialProduct']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'trialProduct': trialProduct.toJson(),
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