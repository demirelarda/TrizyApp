import 'package:equatable/equatable.dart';

abstract class AiSuggestionsEvent extends Equatable {
  const AiSuggestionsEvent();

  @override
  List<Object?> get props => [];
}

class AiSuggestionsRequested extends AiSuggestionsEvent {


  const AiSuggestionsRequested();

  @override
  List<Object?> get props => [];

}