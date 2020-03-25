import 'package:covid19_monitor/model/country_list_model.dart';
import 'package:flutter/foundation.dart';

import 'api_service.dart';

class CountryListRepository {
  final ApiService apiService;

  const CountryListRepository({@required this.apiService});

  Future<CountryList> fetchCountryList() async {
    return await apiService.fetchCountryList();
  }
}
