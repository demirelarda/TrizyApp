import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/address/create_address_request.dart';
import 'package:trizy_app/models/address/create_address_response.dart';
import 'package:trizy_app/models/address/default_address_response.dart';
import 'package:trizy_app/models/address/delete_address_response.dart';
import 'package:trizy_app/models/address/get_address_response.dart';
import 'package:trizy_app/models/address/update_address_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class AddressApiService{

  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();


  Future<CreateAddressResponse> createAddress({required CreateAddressRequest request}) async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.createAddress,
          addAuthToken: true,
          body: request.toJson()
      );
      return CreateAddressResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to create address: $e');
    }
  }


  Future<GetAddressResponse> getUserAddresses() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getUserAddresses,
          addAuthToken: true
      );
      return GetAddressResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get address: $e');
    }
  }


  Future<DeleteAddressResponse> deleteAddress({required String addressId}) async {
    try {
      final response = await _networkingManager.delete(
          endpoint: ApiEndpoints.deleteAddress,
          addAuthToken: true,
          urlParams: {"addressId":addressId}
      );
      return DeleteAddressResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to delete address: $e');
    }
  }


  Future<UpdateAddressResponse> updateAddress({required String addressId, required CreateAddressRequest updatedAddress}) async {
    try {
      final response = await _networkingManager.put(
          endpoint: ApiEndpoints.updateAddress,
          addAuthToken: true,
          urlParams: {"addressId":addressId},
          body: updatedAddress.toJson()
      );
      return UpdateAddressResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to update address: $e');
    }
  }

  Future<DefaultAddressResponse> getDefaultAddress() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getDefaultAddress,
          addAuthToken: true
      );
      return DefaultAddressResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get default address: $e');
    }
  }


}