import 'package:trizy_app/models/trial/create_trial_response.dart';
import 'package:trizy_app/models/trial/get_active_trial_response.dart';
import 'package:trizy_app/services/trial_api_service.dart';

class TrialRepository {
  final TrialApiService trialApiService;

  TrialRepository(this.trialApiService);


  Future<CreateTrialResponse> createTrial({required String trialProductId}) async {
    try {
      final CreateTrialResponse response = await trialApiService.createTrial(trialProductId: trialProductId);
      return response;
    } catch (e) {
      throw Exception('Failed to create trial: $e');
    }
  }

  Future<GetActiveTrialResponse> getActiveTrialDetails() async {
    try {
      final GetActiveTrialResponse response = await trialApiService.getActiveTrialDetails();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch active trial: $e');
    }
  }

}