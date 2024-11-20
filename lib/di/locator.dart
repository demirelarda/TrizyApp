import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<NetworkingManager>(() => NetworkingManager(
    baseUrl: kIsWeb
        ? ApiEndpoints.baseDevWebUrl
        : (Platform.isAndroid ? ApiEndpoints.baseDevAndroidUrl : ApiEndpoints.baseDeviOSUrl),
  ));

}