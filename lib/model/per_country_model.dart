import 'value_model.dart';

class PerCountry {
  final Value confirmed;
  final Value recovered;
  final Value deaths;
  final DateTime lastUpdate;

  const PerCountry({
    this.confirmed,
    this.recovered,
    this.deaths,
    this.lastUpdate,
  });

  factory PerCountry.fromJson(Map<String, dynamic> json) => PerCountry(
        confirmed: Value.fromJson(json["confirmed"]),
        recovered: Value.fromJson(json["recovered"]),
        deaths: Value.fromJson(json["deaths"]),
        lastUpdate: DateTime.parse(json["lastUpdate"]),
      );

  Map<String, dynamic> toJson() => {
        "confirmed": confirmed.toJson(),
        "recovered": recovered.toJson(),
        "deaths": deaths.toJson(),
        "lastUpdate": lastUpdate.toIso8601String(),
      };
}
