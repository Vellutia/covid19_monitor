import 'package:covid19_monitor/model/daily_country_model.dart';
import 'package:flutter/foundation.dart';

import 'api_service.dart';

class DailyCountryRepository {
  final ApiService apiService;

  const DailyCountryRepository({@required this.apiService});

  Future<List<DailyCountry>> fetchDailyCountry(String date) async {
    return await apiService.fetchDailyCountry(date);
  }
}
