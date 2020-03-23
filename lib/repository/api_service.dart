import 'dart:convert';

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
}
