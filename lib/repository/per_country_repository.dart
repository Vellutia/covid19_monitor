import 'package:flutter/foundation.dart';

import '../model/per_country_model.dart';
import 'api_service.dart';

class PerCountryRepository {
  final ApiService apiService;

  const PerCountryRepository({@required this.apiService});

  Future<PerCountry> fetchPerCountry(String country) async {
    return await apiService.fetchPerCountry(country);
  }
}
