import 'package:flutter/material.dart';

import '../../../utils/ui_helper.dart';

class SummaryNumber extends StatelessWidget {
  final String value, title;
  final Color color;

  const SummaryNumber({
    Key key,
    this.value,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '$value',
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
        ),
        verticalSpaceSmall,
        Text(
          '$title',
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: color),
        ),
      ],
    );
  }
}
