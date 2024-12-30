class Review {
  final String id;
  final String productId;
  final ReviewUser user;
  final String orderId;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.productId,
    required this.user,
    required this.orderId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      productId: json['productId'],
      user: ReviewUser.fromJson(json['userId']),
      orderId: json['orderId'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'userId': user.toJson(),
      'orderId': orderId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class ReviewUser {
  final String id;
  final String firstName;
  final String lastName;

  ReviewUser({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['_id'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userFirstName': firstName,
      'userLastName': lastName,
    };
  }
}