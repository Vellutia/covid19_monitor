import 'package:covid19_monitor/model/global_summary_model.dart';
import 'package:covid19_monitor/model/per_country_model.dart';
import 'package:flutter/foundation.dart';

import 'api_service.dart';

class PerCountryRepository {
  final ApiService apiService;

  const PerCountryRepository({@required this.apiService});

  Future<PerCountry> fetchPerCountry(String country) async {
    return await apiService.fetchPerCountry(country);
  }
}
