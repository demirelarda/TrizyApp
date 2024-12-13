import 'package:equatable/equatable.dart';

abstract class DealsEvent extends Equatable {
  const DealsEvent();

  @override
  List<Object?> get props => [];
}

class DealsRequested extends DealsEvent {}