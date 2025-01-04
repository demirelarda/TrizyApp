import 'package:trizy_app/models/user/user_profile_response.dart';
import 'package:trizy_app/services/user_profile_api_service.dart';

class UserProfileRepository {
  final UserProfileApiService userProfileApiService;

  UserProfileRepository(this.userProfileApiService);

  Future<UserProfileResponse> getUserProfile() async {
    try {
      final UserProfileResponse response = await userProfileApiService.getUserProfile();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}