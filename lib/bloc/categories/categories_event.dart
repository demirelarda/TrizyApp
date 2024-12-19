import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class CategoriesRequested extends CategoriesEvent {

  final String? categoryId;

  const CategoriesRequested({
    required this.categoryId,
  });

  @override
  List<Object?> get props => [categoryId];

}