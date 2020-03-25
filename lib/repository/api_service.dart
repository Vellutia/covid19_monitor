import 'dart:convert';

import 'package:covid19_monitor/model/per_country_model.dart';
import 'package:http/http.dart' as http;

import '../model/global_summary_model.dart';
import 'api.dart';

class ApiService {
  final Api api;

  const ApiService(this.api);

  Future<GlobalSummary> fetchGlobalSummary() async {
    final response = await http.get(
      '${api.globalSummaryUri()}',
      headers: {
        'Accept': 'application/json',
      },
    );

    return GlobalSummary.fromJson(json.decode(response.body));
  }

  Future<PerCountry> fetchPerCountry(String country) async {
    final response = await http.get(
      '${api.perCountryUri(country)}',
      headers: {
        'Accept': 'application/json',
      },
    );

    return PerCountry.fromJson(json.decode(response.body));
  }
}
