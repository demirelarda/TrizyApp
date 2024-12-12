import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../repositories/auth_repository.dart';
import '../services/auth_api_service.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<NetworkingManager>(() => NetworkingManager(
    baseUrl: kIsWeb
        ? ApiEndpoints.baseDevWebUrl
        : (Platform.isAndroid ? ApiEndpoints.baseDevAndroidUrl : ApiEndpoints.baseDeviOSUrl),
  ));

  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<AuthApiService>()));

}