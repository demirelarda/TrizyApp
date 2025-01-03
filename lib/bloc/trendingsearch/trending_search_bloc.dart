import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/trendingsearch/trending_search_event.dart';
import 'package:trizy_app/bloc/trendingsearch/trending_search_state.dart';
import 'package:trizy_app/repositories/products_repository.dart';

class TrendingSearchBloc extends Bloc<TrendingSearchEvent, TrendingSearchState> {
  final ProductsRepository productsRepository = GetIt.instance<ProductsRepository>();

  TrendingSearchBloc() : super(TrendingSearchState.initial()) {
    on<TrendingSearchesRequested>(_onTrendingSearchesRequested);
  }

  Future<void> _onTrendingSearchesRequested(TrendingSearchesRequested event, Emitter<TrendingSearchState> emit) async {
    emit(TrendingSearchState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await productsRepository.getTrendingSearches();
      emit(state.copyWith(isLoading: false, isSuccess: true, trendingSearchResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}