import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/address/address_event.dart';
import 'package:trizy_app/bloc/address/address_state.dart';
import 'package:trizy_app/repositories/address_repository.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository = GetIt.instance<
      AddressRepository>();

  AddressBloc() : super(AddressState.initial()) {
    on<CreateAddressEvent>(_onCreateAddressEvent);
    on<DeleteAddressEvent>(_onDeleteAddressEvent);
    on<UpdateAddressEvent>(_onUpdateAddressEvent);
    on<GetAddressesEvent>(_onGetAddressesEvent);
    on<GetDefaultAddressEvent>(_onGetDefaultAddressEvent);
  }

  Future<void> _onCreateAddressEvent(CreateAddressEvent event, Emitter<AddressState> emit,) async {

    emit(AddressState.initial());
    emit(state.copyWith(isLoading: true, operationType: AddressOperationType.create));

    try {
      final response = await addressRepository.createAddress(request: event.request);
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        address: response.address,
        errorMessage: null,
        isFailure: false,
        operationType: null,
        message: response.message,
        addresses: null
      ));
    } catch (error) {
      emit(state.copyWith(
        isSuccess: false,
        isLoading: false,
        isFailure: true,
        errorMessage: error.toString(),
        operationType: null,
        message: null,
        addresses: null,
        address: null,
      ));
    }
  }


  Future<void> _onDeleteAddressEvent(DeleteAddressEvent event, Emitter<AddressState> emit,) async {

    emit(AddressState.initial());
    emit(state.copyWith(isLoading: true, operationType: AddressOperationType.delete));

    try {
      final response = await addressRepository.deleteAddress(addressId: event.addressId);
      emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          address: null,
          errorMessage: null,
          isFailure: false,
          operationType: null,
          message: response.message,
          addresses: null
      ));
    } catch (error) {
      emit(state.copyWith(
        isSuccess: false,
        isLoading: false,
        isFailure: true,
        errorMessage: error.toString(),
        operationType: null,
        message: null,
        addresses: null,
        address: null,
      ));
    }
  }


  Future<void> _onUpdateAddressEvent(UpdateAddressEvent event, Emitter<AddressState> emit,) async {

    emit(AddressState.initial());
    emit(state.copyWith(isLoading: true, operationType: AddressOperationType.update));

    try {
      final response = await addressRepository.updateAddress(updatedAddress: event.request, addressId: event.addressId);
      emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          address: response.address,
          errorMessage: null,
          isFailure: false,
          operationType: null,
          message: response.message,
          addresses: null
      ));
    } catch (error) {
      emit(state.copyWith(
        isSuccess: false,
        isLoading: false,
        isFailure: true,
        errorMessage: error.toString(),
        operationType: null,
        message: null,
        addresses: null,
        address: null,
      ));
    }
  }


  Future<void> _onGetAddressesEvent(GetAddressesEvent event, Emitter<AddressState> emit,) async {

    emit(AddressState.initial());
    emit(state.copyWith(isLoading: true, operationType: AddressOperationType.fetchAll));

    try {
      final response = await addressRepository.getUserAddresses();
      emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          address: null,
          errorMessage: null,
          isFailure: false,
          operationType: null,
          message: null,
          addresses: response.addresses
      ));
    } catch (error) {
      emit(state.copyWith(
        isSuccess: false,
        isLoading: false,
        isFailure: true,
        errorMessage: error.toString(),
        operationType: null,
        message: null,
        addresses: null,
        address: null,
      ));
    }
  }


  Future<void> _onGetDefaultAddressEvent(GetDefaultAddressEvent event, Emitter<AddressState> emit,) async {

    emit(AddressState.initial());
    emit(state.copyWith(isLoading: true, operationType: AddressOperationType.fetchDefault));

    try {
      final response = await addressRepository.getDefaultAddress();
      emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          address: response.address,
          errorMessage: null,
          isFailure: false,
          operationType: null,
          message: null,
          addresses: null
      ));
    } catch (error) {
      emit(state.copyWith(
        isSuccess: false,
        isLoading: false,
        isFailure: false,
        errorMessage: null,
        operationType: null,
        message: null,
        addresses: null,
        address: null,
      ));
    }
  }


}