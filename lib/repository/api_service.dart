import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/global_summary_model.dart';
import 'api.dart';

class ApiService {
  final Api api;

  const ApiService(this.api);

  Future<String> fetchToken() async {
    final response = await http.post(
      '${api.tokenUri()}',
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );
    if (response.statusCode == 200) {
      final String accessToken = json.decode(response.body)['access_token'];
      if (accessToken != null) return accessToken;
    }
    throw response;
  }

  Future<int> fetchCases({
    @required String accessToken,
  }) async {
    final response = await http.get(
      '${api.casesUri()}',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final int result = endpointData['cases'];
        if (result != null) return result;
      }
    }
    throw response;
  }

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
