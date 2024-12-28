import 'package:equatable/equatable.dart';

abstract class TrialProductsEvent extends Equatable {
  const TrialProductsEvent();

  @override
  List<Object?> get props => [];
}

class TrialProductsRequested extends TrialProductsEvent {
  final String? query;
  final String? categoryId;
  final int page;

  const TrialProductsRequested({
    required this.categoryId,
    required this.query,
    required this.page,
  });

  @override
  List<Object?> get props => [query, categoryId, page];
}