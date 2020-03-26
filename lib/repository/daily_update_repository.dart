import 'package:covid19_monitor/model/daily_update_model.dart';
import 'package:flutter/foundation.dart';

import 'api_service.dart';

class DailyUpdateRepository {
  final ApiService apiService;

  const DailyUpdateRepository({@required this.apiService});

  Future<List<DailyUpdate>> fetchDailyUpdate() async {
    return await apiService.fetchDailyUpdate();
  }
}
