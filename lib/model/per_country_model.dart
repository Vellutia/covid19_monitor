import 'package:equatable/equatable.dart';

import 'value_model.dart';

class PerCountry extends Equatable {
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

  @override
  List<Object> get props => [confirmed, recovered, deaths, lastUpdate];

  @override
  bool get stringify => true;
}
