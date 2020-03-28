import 'value_model.dart';

class GlobalSummary {
  final Value confirmed;
  final Value recovered;
  final Value deaths;
  final String source;

  const GlobalSummary({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.source,
  });

  factory GlobalSummary.fromJson(Map<String, dynamic> json) => GlobalSummary(
        confirmed: Value.fromJson(json["confirmed"]),
        recovered: Value.fromJson(json["recovered"]),
        deaths: Value.fromJson(json["deaths"]),
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed.toJson(),
        "recovered": recovered.toJson(),
        "deaths": deaths.toJson(),
        "source": source,
      };
}
