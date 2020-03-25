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
