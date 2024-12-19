import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/category/categories_response.dart';

class CategoriesState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final CategoriesResponse? categoriesResponse;
  final String? errorMessage;

  const CategoriesState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.categoriesResponse,
    this.errorMessage,
  });

  factory CategoriesState.initial() {
    return const CategoriesState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      categoriesResponse: null,
      errorMessage: null,
    );
  }

  CategoriesState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    CategoriesResponse? categoriesResponse,
    String? errorMessage,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      categoriesResponse: categoriesResponse ?? this.categoriesResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, categoriesResponse, errorMessage];
}