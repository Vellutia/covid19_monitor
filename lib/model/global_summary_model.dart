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

class Value {
  final String value;

  const Value({
    this.value,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        value: '${json["value"]}',
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
