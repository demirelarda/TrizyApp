import 'package:equatable/equatable.dart';

abstract class GetCartEvent extends Equatable {
  const GetCartEvent();

  @override
  List<Object?> get props => [];
}

class UserCartRequested extends GetCartEvent {}