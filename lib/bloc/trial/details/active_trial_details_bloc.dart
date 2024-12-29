import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_event.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_state.dart';
import 'package:trizy_app/repositories/trial_repository.dart';

class ActiveTrialDetailsBloc extends Bloc<ActiveTrialDetailsEvent, ActiveTrialDetailsState> {
  final TrialRepository trialRepository = GetIt.instance<TrialRepository>();

  ActiveTrialDetailsBloc() : super(ActiveTrialDetailsState.initial()) {
    on<ActiveTrialDetailsRequested>(_onActiveTrialDetailsRequested);
  }

  Future<void> _onActiveTrialDetailsRequested(ActiveTrialDetailsRequested event, Emitter<ActiveTrialDetailsState> emit) async {
    emit(ActiveTrialDetailsState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await trialRepository.getActiveTrialDetails();
      emit(state.copyWith(isLoading: false, isSuccess: true, getActiveTrialResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}