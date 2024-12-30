class CreateReviewRequest {
  final String orderId;
  final String productId;
  final double rating;
  final String comment;

  CreateReviewRequest({
    required this.orderId,
    required this.productId,
    required this.rating,
    required this.comment,
  });

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) {
    return CreateReviewRequest(
      orderId: json['orderId'],
      productId: json['productId'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'rating': rating,
      'comment': comment,
    };
  }
}