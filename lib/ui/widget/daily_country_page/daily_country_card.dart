import 'package:flutter/material.dart';

import '../../../utils/app_style.dart';
import '../../../utils/ui_helper.dart';
import '../home_page/summary_number.dart';

class DailyCountryCard extends StatelessWidget {
  final String country, confirmed, deaths;

  const DailyCountryCard({
    Key key,
    this.country,
    this.confirmed,
    this.deaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$country',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SummaryNumber(
                  value: confirmed,
                  title: 'Confirmed',
                  color: confirmedColor,
                ),
                SummaryNumber(
                  value: deaths,
                  title: 'Deaths',
                  color: deathsColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
