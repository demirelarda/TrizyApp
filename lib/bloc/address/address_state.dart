import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/address/address.dart';

enum AddressOperationType {
  create,
  update,
  delete,
  fetchAll,
  fetchDefault
}

class AddressState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final Address? address;
  final List<Address>? addresses;
  final String? message;
  final String? errorMessage;
  final AddressOperationType? operationType;

  const AddressState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.addresses,
    this.message,
    this.address,
    this.errorMessage,
    this.operationType,
  });

  factory AddressState.initial() {
    return const AddressState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      addresses: null,
      message: null,
      address: null,
      errorMessage: null,
      operationType: null,
    );
  }

  AddressState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    String? message,
    List<Address>? addresses,
    Address? address,
    AddressOperationType? operationType,
  }) {
    return AddressState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
      address: address ?? this.address,
      addresses: addresses ?? this.addresses,
      operationType: operationType ?? this.operationType,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isFailure,
    errorMessage,
    message,
    addresses,
    address,
    operationType,
  ];
}