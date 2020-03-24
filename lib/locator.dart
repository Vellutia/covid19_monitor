import 'package:get_it/get_it.dart';

import 'repository/api.dart';
import 'repository/api_service.dart';
import 'repository/cases_repository.dart';
import 'repository/global_summary_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api.sandbox());
  locator.registerLazySingleton(() => ApiService(locator<Api>()));

  // Repository
  locator.registerLazySingleton(
      () => CasesRepository(apiService: locator<ApiService>()));
  locator.registerLazySingleton(
      () => GlobalSummaryRepository(apiService: locator<ApiService>()));
}
