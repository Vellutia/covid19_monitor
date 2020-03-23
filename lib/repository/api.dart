class Api {
  static final String scheme = 'https';
  static final String host = 'covid19.mathdro.id';

  Uri globalSummaryUri() => Uri(
        scheme: scheme,
        host: host,
        path: 'api',
      );
}
