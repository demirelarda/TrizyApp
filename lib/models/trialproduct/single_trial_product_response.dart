import 'package:trizy_app/models/trialproduct/trial_products_response.dart';

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