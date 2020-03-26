import 'dart:convert';

import 'package:covid19_monitor/model/country_list_model.dart';
import 'package:covid19_monitor/model/daily_update_model.dart';
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

  Future<CountryList> fetchCountryList() async {
    final response = await http.get(
      '${api.countryListUri()}',
      headers: {
        'Accept': 'application/json',
      },
    );

    return CountryList.fromJson(json.decode(response.body));
  }

  Future<List<DailyUpdate>> fetchDailyUpdate() async {
    final response = await http.get(
      '${api.dailyUpdateUri()}',
      headers: {
        'Accept': 'application/json',
      },
    );

    final listResponse = json.decode(response.body) as List;

    return List<DailyUpdate>.from(
        listResponse.map((e) => DailyUpdate.fromJson(e))).reversed.toList();
  }
}
