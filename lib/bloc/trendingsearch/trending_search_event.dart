import 'package:equatable/equatable.dart';

abstract class TrendingSearchEvent extends Equatable {
  const TrendingSearchEvent();

  @override
  List<Object?> get props => [];
}

class TrendingSearchesRequested extends TrendingSearchEvent {


  const TrendingSearchesRequested();

  @override
  List<Object?> get props => [];

}