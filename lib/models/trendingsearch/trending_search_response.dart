class TrendingSearchResponse {
  final bool success;
  final List<TrendingSearch> trendingSearches;

  TrendingSearchResponse({
    required this.success,
    required this.trendingSearches,
  });

  factory TrendingSearchResponse.fromJson(Map<String, dynamic> json) {
    return TrendingSearchResponse(
      success: json['success'],
      trendingSearches: (json['trendingSearches'] as List)
          .map((item) => TrendingSearch.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'trendingSearches': trendingSearches.map((item) => item.toJson()).toList(),
    };
  }
}

class TrendingSearch {
  final String id;
  final String trendingSearchTerm;
  final int occurrenceCount;

  TrendingSearch({
    required this.id,
    required this.trendingSearchTerm,
    required this.occurrenceCount,
  });

  factory TrendingSearch.fromJson(Map<String, dynamic> json) {
    return TrendingSearch(
      id: json['_id'],
      trendingSearchTerm: json['trendingSearchTerm'],
      occurrenceCount: json['occurrenceCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'trendingSearchTerm': trendingSearchTerm,
      'occurrenceCount': occurrenceCount,
    };
  }
}