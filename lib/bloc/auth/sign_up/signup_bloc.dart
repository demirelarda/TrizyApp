import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/auth/sign_up/signup_event.dart';
import 'package:trizy_app/bloc/auth/sign_up/signup_state.dart';
import '../../../models/auth/request/sign_up_request.dart';
import '../../../repositories/auth_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository = GetIt.instance<AuthRepository>();

  SignupBloc() : super(SignupState.initial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupState.initial());
    emit(state.copyWith(isSubmitting: true));

    try {
      final request = SignUpRequest(
        email: event.email,
        userFirstName: event.firstName,
        userLastName: event.lastName,
        password: event.password,
      );

      final response = await authRepository.signUp(request);

      emit(state.copyWith(isSubmitting: false, isSuccess: true, user: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}