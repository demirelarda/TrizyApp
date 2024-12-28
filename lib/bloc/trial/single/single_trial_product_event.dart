import 'package:equatable/equatable.dart';

abstract class SingleTrialProductEvent extends Equatable {
  const SingleTrialProductEvent();

  @override
  List<Object?> get props => [];
}

class SingleTrialProductRequested extends SingleTrialProductEvent {

  final String trialProductId;

  const SingleTrialProductRequested({
    required this.trialProductId,
  });

  @override
  List<Object?> get props => [trialProductId];
}