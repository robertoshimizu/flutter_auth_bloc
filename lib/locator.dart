import 'package:flutter_auth_bloc/data/external_apis/firebase_instance.dart';

import 'package:get_it/get_it.dart';

import 'data/repository/repositories.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => DatabaseService('users'));
  locator.registerLazySingleton(() => FirebaseInstance());
  locator.registerLazySingleton(() => DataUserRepository());
  locator.registerLazySingleton(() => DataAuthRepository());
  locator.registerLazySingleton(() => DataAllRequests());
  // locator.registerLazySingleton(() => DatabaseServices());
}
