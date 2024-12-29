import 'package:equatable/equatable.dart';

abstract class ActiveTrialDetailsEvent extends Equatable {
  const ActiveTrialDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ActiveTrialDetailsRequested extends ActiveTrialDetailsEvent {

  const ActiveTrialDetailsRequested();

  @override
  List<Object?> get props => [];

}