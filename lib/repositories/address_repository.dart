import 'package:trizy_app/models/address/create_address_response.dart';
import 'package:trizy_app/models/address/default_address_response.dart';
import 'package:trizy_app/models/address/delete_address_response.dart';
import 'package:trizy_app/models/address/get_address_response.dart';
import 'package:trizy_app/models/address/update_address_response.dart';
import 'package:trizy_app/services/address_api_service.dart';
import '../models/address/create_address_request.dart';

class AddressRepository{

  final AddressApiService addressApiService;

  AddressRepository(this.addressApiService);


  Future<CreateAddressResponse> createAddress({required CreateAddressRequest request}) async {
    try {
      final CreateAddressResponse response = await addressApiService.createAddress(request: request);
      return response;
    } catch (e) {
      throw Exception('Failed to create address: $e');
    }
  }


  Future<GetAddressResponse> getUserAddresses() async {
    try {
      final GetAddressResponse response = await addressApiService.getUserAddresses();
      return response;
    } catch (e) {
      throw Exception('Failed to get addresses: $e');
    }
  }


  Future<DeleteAddressResponse> deleteAddress({required String addressId}) async {
    try {
      final DeleteAddressResponse response = await addressApiService.deleteAddress(addressId: addressId);
      return response;
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  Future<UpdateAddressResponse> updateAddress({required CreateAddressRequest updatedAddress, required String addressId}) async {
    try {
      final UpdateAddressResponse response = await addressApiService.updateAddress(addressId: addressId, updatedAddress: updatedAddress);
      return response;
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }


  Future<DefaultAddressResponse> getDefaultAddress() async {
    try {
      final DefaultAddressResponse response = await addressApiService.getDefaultAddress();
      return response;
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }


}