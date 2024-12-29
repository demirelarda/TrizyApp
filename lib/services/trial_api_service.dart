import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/trial/create_trial_response.dart';
import 'package:trizy_app/models/trial/get_active_trial_response.dart';

import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class TrialApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();


  Future<CreateTrialResponse> createTrial({required String trialProductId}) async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.createTrial,
          body: {"trialProductId":trialProductId},
          addAuthToken: true
      );
      return CreateTrialResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to create trial: $e');
    }
  }


  Future<GetActiveTrialResponse> getActiveTrialDetails() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getActiveTrialDetails,
          addAuthToken: true
      );
      return GetActiveTrialResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get active trial details: $e');
    }
  }


}