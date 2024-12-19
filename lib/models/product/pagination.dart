class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalProducts;
  final int limit;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalProducts,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalProducts: json['totalProducts'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'totalProducts': totalProducts,
      'limit': limit,
    };
  }
}