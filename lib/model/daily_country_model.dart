class DailyCountry {
  final String admin2;
  final String provinceState;
  final String countryRegion;
  final String confirmed;
  final String deaths;

  DailyCountry({
    this.admin2,
    this.provinceState,
    this.countryRegion,
    this.confirmed,
    this.deaths,
  });

  factory DailyCountry.fromJson(Map<String, dynamic> json) => DailyCountry(
        admin2: json["admin2"] == '' || json["admin2"] == null
            ? null
            : json["admin2"],
        provinceState:
            json["provinceState"] == '' || json["provinceState"] == null
                ? null
                : json["provinceState"],
        countryRegion: json["countryRegion"],
        confirmed: json["confirmed"] == '' ? '0' : json["confirmed"],
        deaths: json["deaths"] == '' ? '0' : json["deaths"],
      );

  Map<String, dynamic> toJson() => {
        "admin2": admin2,
        "provinceState": provinceState,
        "countryRegion": countryRegion,
        "confirmed": confirmed,
        "deaths": deaths,
      };
}
