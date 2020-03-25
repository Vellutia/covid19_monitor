import 'package:covid19_monitor/model/global_summary_model.dart';
import 'package:flutter/foundation.dart';

import 'api_service.dart';

class GlobalSummaryRepository {
  final ApiService apiService;

  const GlobalSummaryRepository({@required this.apiService});

  Future<GlobalSummary> fetchPerCountry(String country) async {
    return await apiService.fetchPerCountry(country);
  }
}
