import 'package:equatable/equatable.dart';

abstract class SignOutEvent extends Equatable {
  const SignOutEvent();

  @override
  List<Object?> get props => [];
}

class SignOutRequested extends SignOutEvent {

  const SignOutRequested();

  @override
  List<Object?> get props => [];
}