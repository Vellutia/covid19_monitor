import 'package:covid19_monitor/repository/country_list_repository.dart';
import 'package:covid19_monitor/repository/daily_country_repository.dart';
import 'package:covid19_monitor/repository/daily_update_repository.dart';
import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:get_it/get_it.dart';

import 'repository/api.dart';
import 'repository/api_service.dart';
import 'repository/global_summary_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => ApiService(locator<Api>()));

  // Repository
  locator.registerLazySingleton(
      () => GlobalSummaryRepository(apiService: locator<ApiService>()));
  locator.registerLazySingleton(
      () => PerCountryRepository(apiService: locator<ApiService>()));
  locator.registerLazySingleton(
      () => CountryListRepository(apiService: locator<ApiService>()));
  locator.registerLazySingleton(
      () => DailyUpdateRepository(apiService: locator<ApiService>()));
  locator.registerLazySingleton(
      () => DailyCountryRepository(apiService: locator<ApiService>()));
}
