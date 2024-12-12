import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/auth/sign_in/signin_event.dart';
import 'package:trizy_app/bloc/auth/sign_in/signin_state.dart';
import '../../../models/auth/request/sign_in_request.dart';
import '../../../repositories/auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository = GetIt.instance<AuthRepository>();

  SignInBloc() : super(SignInState.initial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  Future<void> _onSignInSubmitted(SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isLoggingIn: true));

    try {
      final request = SignInRequest(
        email: event.email,
        password: event.password,
      );

      final response = await authRepository.signIn(request);

      emit(state.copyWith(isLoggingIn: false, isSuccess: true, user: response));
    } catch (error) {
      emit(state.copyWith(isLoggingIn: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}