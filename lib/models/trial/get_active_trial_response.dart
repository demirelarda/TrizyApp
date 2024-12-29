class GetActiveTrialResponse {
  final bool success;
  final String message;
  final TrialDetail trial;

  GetActiveTrialResponse({
    required this.success,
    required this.message,
    required this.trial,
  });

  factory GetActiveTrialResponse.fromJson(Map<String, dynamic> json) {
    return GetActiveTrialResponse(
      success: json['success'],
      message: json['message'],
      trial: TrialDetail.fromJson(json['trial']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'trial': trial.toJson(),
    };
  }
}

class TrialDetail {
  final String id;
  final String userId;
  final MinifiedTrialProduct trialProduct;
  final String startDate;
  final String endDate;
  final String status;
  final String? feedback;
  final String createdAt;
  final String updatedAt;

  TrialDetail({
    required this.id,
    required this.userId,
    required this.trialProduct,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.feedback,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrialDetail.fromJson(Map<String, dynamic> json) {
    return TrialDetail(
      id: json['_id'],
      userId: json['userId'],
      trialProduct: MinifiedTrialProduct.fromJson(json['trialProductId']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      feedback: json['feedback'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'trialProductId': trialProduct.toJson(),
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'feedback': feedback,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class MinifiedTrialProduct {
  final String id;
  final List<String> imageURLs;
  final String title;
  final int trialPeriod;

  MinifiedTrialProduct({
    required this.id,
    required this.imageURLs,
    required this.title,
    required this.trialPeriod,
  });

  factory MinifiedTrialProduct.fromJson(Map<String, dynamic> json) {
    return MinifiedTrialProduct(
      id: json['_id'],
      imageURLs: List<String>.from(json['imageURLs']),
      title: json['title'],
      trialPeriod: json['trialPeriod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageURLs': imageURLs,
      'title': title,
      'trialPeriod': trialPeriod,
    };
  }
}