class Subscription {
  final String id;
  final String userId;
  final String stripeSubscriptionId;
  final bool isActive;
  final String status;
  final DateTime? startedAt;
  final DateTime? expiresAt;
  final DateTime? canceledAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.stripeSubscriptionId,
    required this.isActive,
    required this.status,
    this.startedAt,
    this.expiresAt,
    this.canceledAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      stripeSubscriptionId: json['stripeSubscriptionId'] as String,
      isActive: json['isActive'] as bool,
      status: json['status'] as String,
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'])
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      canceledAt: json['canceledAt'] != null
          ? DateTime.parse(json['canceledAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'stripeSubscriptionId': stripeSubscriptionId,
      'isActive': isActive,
      'status': status,
      'startedAt': startedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'canceledAt': canceledAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}