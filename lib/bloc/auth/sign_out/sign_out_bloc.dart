import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizy_app/bloc/auth/sign_out/sign_out_event.dart';
import 'package:trizy_app/bloc/auth/sign_out/sign_out_state.dart';
import '../../../di/locator.dart';
import '../../../services/local/local_product_service.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {

  final LocalProductService localProductService = getIt<LocalProductService>();

  SignOutBloc() : super(SignOutState.initial()) {
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<SignOutState> emit) async {
    emit(SignOutState.initial());
    emit(state.copyWith(isLoading: true));

    try {

      await localProductService.deleteAllLocalData();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user');
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');

      emit(state.copyWith(isLoading: false, isFailure: false, isSuccess: true));

    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}