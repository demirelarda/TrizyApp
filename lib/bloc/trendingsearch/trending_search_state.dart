import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/trendingsearch/trending_search_response.dart';

class TrendingSearchState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final TrendingSearchResponse? trendingSearchResponse;
  final String? errorMessage;

  const TrendingSearchState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.trendingSearchResponse,
    this.errorMessage,
  });

  factory TrendingSearchState.initial() {
    return const TrendingSearchState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      trendingSearchResponse: null,
      errorMessage: null,
    );
  }

  TrendingSearchState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    TrendingSearchResponse? trendingSearchResponse,
    String? errorMessage,
  }) {
    return TrendingSearchState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      trendingSearchResponse: trendingSearchResponse ?? this.trendingSearchResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, trendingSearchResponse, errorMessage];
}