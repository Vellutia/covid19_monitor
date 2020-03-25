class CountryList {
  final List<Country> countries;

  const CountryList({
    this.countries,
  });

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  final String name;

  const Country({
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
