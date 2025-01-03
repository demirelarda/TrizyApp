class Deal {
  final int dealOrder;
  final String imageUrl;
  final String title;
  final String? description;
  final String action;
  final String aspectRatio;

  Deal({
    required this.dealOrder,
    required this.imageUrl,
    required this.title,
    this.description,
    required this.action,
    required this.aspectRatio,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      dealOrder: json['dealOrder'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      action: json['action'],
      aspectRatio: json['aspectRatio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dealOrder': dealOrder,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'action': action,
      'aspectRatio': aspectRatio,
    };
  }

  double get aspectRatioValue {
    final parts = aspectRatio.split(':');
    if (parts.length == 2) {
      final width = double.tryParse(parts[0]) ?? 1;
      final height = double.tryParse(parts[1]) ?? 1;
      return width / height;
    }
    return 1.0;
  }
}

List<Deal> parseDeals(dynamic jsonList) {
  return (jsonList as List).map((json) => Deal.fromJson(json)).toList();
}