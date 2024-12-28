import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/trial/single/single_trial_product_event.dart';
import 'package:trizy_app/bloc/trial/single/single_trial_product_state.dart';
import '../../../repositories/trial_product_repository.dart';

class SingleTrialProductBloc extends Bloc<SingleTrialProductEvent, SingleTrialProductState> {
  final TrialProductsRepository trialProductsRepository = GetIt.instance<TrialProductsRepository>();

  SingleTrialProductBloc() : super(SingleTrialProductState.initial()) {
    on<SingleTrialProductRequested>(_onSingleTrialProductRequested);
  }

  Future<void> _onSingleTrialProductRequested(
      SingleTrialProductRequested event, Emitter<SingleTrialProductState> emit) async {
    emit(SingleTrialProductState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await trialProductsRepository.getSingleTrialProduct(productId: event.trialProductId);
      emit(state.copyWith(
          isLoading: false, isSuccess: true, singleTrialProductResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}