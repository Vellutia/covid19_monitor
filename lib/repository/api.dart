class Api {
  static const String scheme = 'https';
  static const String host = 'covid19.mathdro.id';

  Uri globalSummaryUri() => Uri(
        scheme: scheme,
        host: host,
        path: 'api',
      );

  Uri perCountryUri(String country) => Uri(
        scheme: scheme,
        host: host,
        path: 'api/countries/$country',
      );

  Uri countryListUri() => Uri(
        scheme: scheme,
        host: host,
        path: 'api/countries',
      );

  Uri dailyUpdateUri() => Uri(
        scheme: scheme,
        host: host,
        path: 'api/daily',
      );

  Uri dailyCountryUri(String date) => Uri(
        scheme: scheme,
        host: host,
        path: 'api/daily/$date',
      );
}
