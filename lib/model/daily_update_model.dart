import 'package:equatable/equatable.dart';

class DailyUpdate extends Equatable {
  final int mainlandChina;
  final int otherLocations;
  final Details deltaConfirmedDetail;
  final Details deaths;
  final DateTime reportDate;

  const DailyUpdate({
    this.mainlandChina,
    this.otherLocations,
    this.deltaConfirmedDetail,
    this.deaths,
    this.reportDate,
  });

  factory DailyUpdate.fromJson(Map<String, dynamic> json) => DailyUpdate(
        mainlandChina: json["mainlandChina"],
        otherLocations: json["otherLocations"],
        deltaConfirmedDetail: Details.fromJson(json["deltaConfirmedDetail"]),
        deaths: Details.fromJson(json["deaths"]),
        reportDate: DateTime.parse(json["reportDate"]),
      );

  Map<String, dynamic> toJson() => {
        "mainlandChina": mainlandChina,
        "otherLocations": otherLocations,
        "deltaConfirmedDetail": deltaConfirmedDetail.toJson(),
        "deaths": deaths.toJson(),
        "reportDate":
            "${reportDate.year.toString().padLeft(4, '0')}-${reportDate.month.toString().padLeft(2, '0')}-${reportDate.day.toString().padLeft(2, '0')}",
      };

  @override
  List<Object> get props => [
        mainlandChina,
        otherLocations,
        deltaConfirmedDetail,
        deaths,
        reportDate,
      ];

  @override
  bool get stringify => true;
}

class Details extends Equatable {
  final int total;

  const Details({
    this.total,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };

  @override
  List<Object> get props => [total];

  @override
  bool get stringify => true;
}
