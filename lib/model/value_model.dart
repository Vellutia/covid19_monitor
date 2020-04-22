import 'package:equatable/equatable.dart';

class Value extends Equatable {
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

  @override
  List<Object> get props => [value];
}
