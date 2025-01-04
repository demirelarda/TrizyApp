import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/profile/user_profile_event.dart';
import 'package:trizy_app/bloc/profile/user_profile_state.dart';
import 'package:trizy_app/repositories/user_profile_repository.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository = GetIt.instance<UserProfileRepository>();

  UserProfileBloc() : super(UserProfileState.initial()) {
    on<UserProfileRequested>(_onUserProfileRequested);
  }

  Future<void> _onUserProfileRequested(UserProfileRequested event, Emitter<UserProfileState> emit) async {
    emit(UserProfileState.initial());
    emit(state.copyWith(isLoading: true));
    try {
      final response = await userProfileRepository.getUserProfile();
      emit(state.copyWith(isLoading: false, isSuccess: true, userProfileResponse: response, errorMessage: null, isFailure: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: error.toString()));
    }
  }
}