import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

import 'core/core.dart';
import 'features/features.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Bloc

  serviceLocator.registerFactory(
    () => AuthenticationBloc(
      loginUsecase: serviceLocator(),
      logoutUsecase: serviceLocator(),
      fetchUserUsecase: serviceLocator(),
      fetchEventUsecase: serviceLocator(),
    ),
  );

  //! Usecase

  serviceLocator.registerLazySingleton(
    () => LoginUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => LogoutUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchUserUsecase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => FetchEventUsecase(repository: serviceLocator()),
  );

  //! Repository

  serviceLocator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  //! Datasources

  serviceLocator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(
      flutterSecureStorage: serviceLocator(),
    ),
  );

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: serviceLocator()),
  );

  //! External-----------------------------------
  const flutterSecureStorage = FlutterSecureStorage();
  serviceLocator.registerFactory(() => flutterSecureStorage);

  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
