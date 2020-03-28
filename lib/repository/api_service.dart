import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/country_list_model.dart';
import '../model/daily_country_model.dart';
import '../model/daily_update_model.dart';
import '../model/global_summary_model.dart';
import '../model/per_country_model.dart';
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

  Future<List<DailyCountry>> fetchDailyCountry(String date) async {
    final response = await http.get(
      '${api.dailyCountryUri(date)}',
      headers: {
        'Accept': 'application/json',
      },
    );

    final listResponse = json.decode(response.body) as List;

    return List<DailyCountry>.from(listResponse
        .map((e) => DailyCountry.fromJson(e))
        .where((e) => !(e.confirmed == '0' && e.deaths == '0')));
  }
}
