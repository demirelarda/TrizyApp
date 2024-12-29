import 'package:equatable/equatable.dart';

abstract class CreateTrialEvent extends Equatable {
  const CreateTrialEvent();

  @override
  List<Object?> get props => [];
}

class TrialCreationRequested extends CreateTrialEvent {

  final String trialProductId;

  const TrialCreationRequested({
    required this.trialProductId
  });

  @override
  List<Object?> get props => [trialProductId];

}