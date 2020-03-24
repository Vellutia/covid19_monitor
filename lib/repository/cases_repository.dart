import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'api_service.dart';

class CasesRepository {
  final ApiService apiService;

  CasesRepository({@required this.apiService});

  String _accessToken;

  Future<int> fetchCases() async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.fetchToken();
      }
      return await apiService.fetchCases(
        accessToken: _accessToken,
      );
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.fetchToken();
        return await apiService.fetchCases(
          accessToken: _accessToken,
        );
      }
      rethrow;
    }
  }
}
