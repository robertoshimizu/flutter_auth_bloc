import 'package:get_it/get_it.dart';

import 'data/repository/repositories.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => DatabaseService('users'));
  locator.registerLazySingleton(() => FirebaseService());
}
