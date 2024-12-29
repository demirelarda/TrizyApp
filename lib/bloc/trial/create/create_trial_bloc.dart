import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/trial/create/create_trial_event.dart';
import 'package:trizy_app/bloc/trial/create/create_trial_state.dart';
import 'package:trizy_app/repositories/trial_repository.dart';

class CreateTrialBloc extends Bloc<CreateTrialEvent, CreateTrialState> {
  final TrialRepository trialRepository = GetIt.instance<TrialRepository>();

  CreateTrialBloc() : super(CreateTrialState.initial()) {
    on<TrialCreationRequested>(_onTrialCreationRequested);
  }

  Future<void> _onTrialCreationRequested(TrialCreationRequested event, Emitter<CreateTrialState> emit) async {
    emit(CreateTrialState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await trialRepository.createTrial(trialProductId: event.trialProductId);
      emit(state.copyWith(isLoading: false, isSuccess: true, createTrialResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}