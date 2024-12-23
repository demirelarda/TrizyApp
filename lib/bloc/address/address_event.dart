import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/address/create_address_request.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}


class CreateAddressEvent extends AddressEvent {

  final CreateAddressRequest request;

  const CreateAddressEvent({required this.request});

  @override
  List<Object?> get props => [request];

}


class GetAddressesEvent extends AddressEvent {

  const GetAddressesEvent();

  @override
  List<Object?> get props => [];

}


class UpdateAddressEvent extends AddressEvent {

  final String addressId;
  final CreateAddressRequest request;

  const UpdateAddressEvent({required this.addressId, required this.request});

  @override
  List<Object?> get props => [request, addressId];

}


class DeleteAddressEvent extends AddressEvent {

  final String addressId;

  const DeleteAddressEvent({required this.addressId});

  @override
  List<Object?> get props => [addressId];

}


class GetDefaultAddressEvent extends AddressEvent {

  const GetDefaultAddressEvent();

  @override
  List<Object?> get props => [];

}
