import 'package:flutter/foundation.dart';

import '../model/daily_country_model.dart';
import 'api_service.dart';

class DailyCountryRepository {
  final ApiService apiService;

  const DailyCountryRepository({@required this.apiService});

  Future<List<DailyCountry>> fetchDailyCountry(String date) async {
    return await apiService.fetchDailyCountry(date);
  }
}
