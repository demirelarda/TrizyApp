import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/bloc/subscription/subscription_event.dart';
import 'package:trizy_app/bloc/subscription/subscription_state.dart';
import 'package:trizy_app/repositories/subscription_repository.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepository = GetIt.instance<SubscriptionRepository>();

  SubscriptionBloc() : super(SubscriptionState.initial()) {
    on<CreateSubscriptionEvent>(_onCreateSubscriptionEvent);
    on<GetSubscriptionStatusEvent>(_onGetSubscriptionStatusEvent);
    on<CancelSubscriptionEvent>(_onCancelSubscriptionEvent);
  }

  Future<void> _onCreateSubscriptionEvent(
      CreateSubscriptionEvent event,
      Emitter<SubscriptionState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
        operationType: SubscriptionOperationType.create,
        isSuccess: false,
        isFailure: false,
        errorMessage: null,
        message: null,
        subscriptionStatus: null,
        clientSecret: null,
        subscription: null,
      ),
    );

    try {
      final response = await subscriptionRepository.createSubscription(request: event.request);
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          operationType: SubscriptionOperationType.create,
          isFailure: false,
          errorMessage: null,
          message: response.message,
          subscription: response.subscription,
          subscriptionStatus: response.subscriptionStatus,
          clientSecret: response.clientSecret,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSuccess: false,
          isLoading: false,
          isFailure: true,
          errorMessage: error.toString(),
          operationType: null,
          message: null,
          subscriptionStatus: null,
          subscription: null,
          clientSecret: null,
        ),
      );
    }
  }

  Future<void> _onGetSubscriptionStatusEvent(
      GetSubscriptionStatusEvent event,
      Emitter<SubscriptionState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
        operationType: SubscriptionOperationType.getStatus,
        isSuccess: false,
        isFailure: false,
        errorMessage: null,
        message: null,
      ),
    );

    try {
      final response = await subscriptionRepository.getSubscriptionStatus();

      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          errorMessage: null,
          operationType: null,
          message: null,
          subscription: response.subscription,
          subscriptionStatus: response.subscription.status,
          clientSecret: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSuccess: false,
          isLoading: false,
          isFailure: true,
          errorMessage: error.toString(),
          operationType: null,
          message: null,
          subscriptionStatus: null,
          subscription: null,
          clientSecret: null,
        ),
      );
    }
  }

  Future<void> _onCancelSubscriptionEvent(
      CancelSubscriptionEvent event,
      Emitter<SubscriptionState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
        operationType: SubscriptionOperationType.cancel,
        isSuccess: false,
        isFailure: false,
        errorMessage: null,
        message: null,
        subscriptionStatus: null,
        clientSecret: null,
        subscription: null,
      ),
    );

    try {
      final response = await subscriptionRepository.cancelSubscription(
        subscriptionId: event.subscriptionId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          errorMessage: null,
          operationType: null,
          message: response.message,
          subscription: response.subscription,
          subscriptionStatus: response.subscription.status,
          clientSecret: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSuccess: false,
          isLoading: false,
          isFailure: true,
          errorMessage: error.toString(),
          operationType: null,
          message: null,
          subscriptionStatus: null,
          subscription: null,
          clientSecret: null,
        ),
      );
    }
  }
}