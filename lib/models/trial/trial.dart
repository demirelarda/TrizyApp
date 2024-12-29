class Trial {
  final String userId;
  final String trialProductId;
  final String startDate;
  final String endDate;
  final String status;
  final String? feedback;
  final String id;
  final String createdAt;
  final String updatedAt;

  Trial({
    required this.userId,
    required this.trialProductId,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.feedback,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trial.fromJson(Map<String, dynamic> json) {
    return Trial(
      userId: json['userId'],
      trialProductId: json['trialProductId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      feedback: json['feedback'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'trialProductId': trialProductId,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'feedback': feedback,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}