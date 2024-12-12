import 'package:get_it/get_it.dart';
import '../models/auth/request/sign_in_request.dart';
import '../models/auth/request/sign_up_request.dart';
import '../models/auth/response/sign_in_response.dart';
import '../models/auth/response/sign_up_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class AuthApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<SignUpResponse> register(SignUpRequest request) async {
    try {
      final response = await _networkingManager.post(
        endpoint: ApiEndpoints.register,
        body: request.toJson(),
      );
      return SignUpResponse.fromJson(response);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
  
  Future<SignInResponse> signIn(SignInRequest request) async{
    
    try{
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.login,
          body: request.toJson()
      );
      return SignInResponse.fromJson(response);

    }
    catch(e){
      throw Exception('Sign in failed: $e');
    }

  }

}