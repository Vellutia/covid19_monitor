import 'package:flutter/foundation.dart';

import '../model/global_summary_model.dart';
import 'api_service.dart';

class GlobalSummaryRepository {
  final ApiService apiService;

  const GlobalSummaryRepository({@required this.apiService});

  Future<GlobalSummary> fetchGlobalSummary() async {
    return await apiService.fetchGlobalSummary();
  }
}
