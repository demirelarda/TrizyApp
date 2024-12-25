import 'package:equatable/equatable.dart';

abstract class GetOrdersEvent extends Equatable {
  const GetOrdersEvent();

  @override
  List<Object?> get props => [];
}

class UserOrdersRequested extends GetOrdersEvent {

  final int page;

  const UserOrdersRequested({
    required this.page,
  });

  @override
  List<Object?> get props => [page];

}