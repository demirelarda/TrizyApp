import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_event.dart';
import 'package:trizy_app/bloc/ai/ai_suggestions_state.dart';
import 'package:trizy_app/repositories/ai_suggestions_repository.dart';

class AiSuggestionsBloc extends Bloc<AiSuggestionsEvent, AiSuggestionsState> {
  final AiSuggestionsRepository aiSuggestionsRepository = GetIt.instance<AiSuggestionsRepository>();

  AiSuggestionsBloc() : super(AiSuggestionsState.initial()) {
    on<AiSuggestionsRequested>(_onAiSuggestionsRequested);
  }

  Future<void> _onAiSuggestionsRequested(AiSuggestionsRequested event, Emitter<AiSuggestionsState> emit) async {
    emit(AiSuggestionsState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await aiSuggestionsRepository.getAiSuggestions();
      emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          productsResponse: response,
          errorMessage: null,
          isFailure: false
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}