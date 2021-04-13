import 'package:frontend/repository/task_repository.dart';
import 'package:frontend/services/api_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;
setupLocator() {
  //services
  locator.registerLazySingleton(() => ApiService());

  //repos
  locator.registerLazySingleton(() => TaskRepository());
}
