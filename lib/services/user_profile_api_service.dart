import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/user/user_profile_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class UserProfileApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<UserProfileResponse> getUserProfile() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getUserProfileDetails,
          addAuthToken: true
      );
      return UserProfileResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}