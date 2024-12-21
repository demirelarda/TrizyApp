import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:trizy_app/repositories/cart_repository.dart';
import 'package:trizy_app/repositories/categories_repository.dart';
import 'package:trizy_app/repositories/deals_repository.dart';
import 'package:trizy_app/repositories/products_repository.dart';
import 'package:trizy_app/services/cart_api_service.dart';
import 'package:trizy_app/services/categories_api_service.dart';
import 'package:trizy_app/services/deals_api_service.dart';
import 'package:trizy_app/services/products_api_service.dart';
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
  getIt.registerLazySingleton<DealsApiService>(() => DealsApiService());
  getIt.registerLazySingleton<DealsRepository>(() => DealsRepository(getIt<DealsApiService>()));
  getIt.registerLazySingleton<CategoriesApiService>(() => CategoriesApiService());
  getIt.registerLazySingleton<CategoriesRepository>(() => CategoriesRepository(getIt<CategoriesApiService>()));
  getIt.registerLazySingleton<ProductsApiService>(() => ProductsApiService());
  getIt.registerLazySingleton<ProductsRepository>(() => ProductsRepository(getIt<ProductsApiService>()));
  getIt.registerLazySingleton<CartApiService>(() => CartApiService());
  getIt.registerLazySingleton<CartRepository>(() => CartRepository(getIt<CartApiService>()));

}