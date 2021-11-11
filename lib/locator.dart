import 'package:flutter_todo_app/core/service/database_service.dart';
import 'package:flutter_todo_app/core/utils/utils.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Database());
  locator.registerLazySingleton(() => Utils());


}