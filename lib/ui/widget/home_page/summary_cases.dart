import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';

class SummaryCases extends StatelessWidget {
  final String cases;
  final BoxConstraints constraints;

  const SummaryCases({
    Key key,
    this.cases,
    this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.7,
      width: constraints.maxHeight * 0.7,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              '$cases',
              maxLines: 1,
              style: Theme.of(context).textTheme.headline6,
            ),
            AutoSizeText(
              'Cases reported',
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: labelColor),
            ),
          ],
        ),
      ),
    );
  }
}
