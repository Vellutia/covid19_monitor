import 'package:flutter/foundation.dart';

import 'api_key.dart';

class Api {
  final String apiKey;

  const Api({@required this.apiKey});

  factory Api.sandbox() => Api(apiKey: ApiKey.ncovSandboxKey);
  factory Api.prod() => Api(apiKey: ApiKey.ncovProdKey);

  static const String scheme = 'https';
  static const String host = 'apigw.nubentos.com';
  static const String host2 = 'covid19.mathdro.id';
  static const int sandboxPort = 443;
  static const int prodPort = 80;

  Uri tokenUri() => Uri(
        scheme: scheme,
        host: host,
        port: sandboxPort,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri casesUri() => Uri(
        scheme: 'https',
        host: host,
        port: sandboxPort,
        path: 't/nubentos.com/ncovapi/1.0.0/cases',
      );

  Uri globalSummaryUri() => Uri(
        scheme: scheme,
        host: host2,
        path: 'api',
      );
}
