import 'package:flutter_auth_bloc/data/external_apis/firestore_instance.dart';

import 'package:get_it/get_it.dart';

import 'data/external_apis/firebase_auth_instance.dart';
import 'data/repository/repositories.dart';
import 'domain/repository/contactSelection_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirestoreInstance());
  locator.registerLazySingleton(() => FirebaseAuthInstance());
  locator.registerLazySingleton(() => DataUserRepository());
  locator.registerLazySingleton(() => DataAuthRepository());
  locator.registerLazySingleton(() => DataAllRequests());
  locator.registerLazySingleton(() => MyContactSelection([], []));
}
