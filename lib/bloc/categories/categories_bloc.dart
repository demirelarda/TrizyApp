import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/categories/categories_event.dart';
import 'package:trizy_app/bloc/categories/categories_state.dart';
import 'package:trizy_app/repositories/categories_repository.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository = GetIt.instance<CategoriesRepository>();

  CategoriesBloc() : super(CategoriesState.initial()) {
    on<CategoriesRequested>(_onCategoriesRequested);
  }

  Future<void> _onCategoriesRequested(CategoriesRequested event, Emitter<CategoriesState> emit) async {
    emit(CategoriesState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      if(event.categoryId != null){
        final response = await categoriesRepository.getChildCategories(event.categoryId!);
        emit(state.copyWith(isLoading: false, isSuccess: true, categoriesResponse: response, errorMessage: null, isFailure: false));
      }
      else{
        final response = await categoriesRepository.getRootCategories();
        emit(state.copyWith(isLoading: false, isSuccess: true, categoriesResponse: response, errorMessage: null, isFailure: false));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}