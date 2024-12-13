import 'deal.dart';

class DealsResponse {
  final List<Deal> deals;

  DealsResponse({required this.deals});

  factory DealsResponse.fromJson(Map<String, dynamic> json) {
    return DealsResponse(
      deals: parseDeals(json['deals']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deals': deals.map((deal) => deal.toJson()).toList(),
    };
  }
}