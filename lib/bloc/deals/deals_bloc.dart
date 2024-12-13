import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/deals/deals_event.dart';
import 'package:trizy_app/bloc/deals/deals_state.dart';
import 'package:trizy_app/repositories/deals_repository.dart';

class DealsBloc extends Bloc<DealsEvent, DealsState> {
  final DealsRepository dealsRepository = GetIt.instance<DealsRepository>();

  DealsBloc() : super(DealsState.initial()) {
    on<DealsRequested>(_onDealsRequested);
  }

  Future<void> _onDealsRequested(DealsRequested event, Emitter<DealsState> emit) async {
    emit(DealsState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await dealsRepository.getDeals();
      emit(state.copyWith(isLoading: false, isSuccess: true, deals: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}