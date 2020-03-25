import 'package:covid19_monitor/bloc/global_summary_bloc.dart';
import 'package:covid19_monitor/ui/widget/home_page/summary_number.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCard extends StatelessWidget {
  final String Function(int) formatValue;

  const CountryCard({
    Key key,
    this.formatValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              'Per Country Data',
              style: Theme.of(context).accentTextTheme.subtitle1,
            ),
          ),
          Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: BlocBuilder<GlobalSummaryBloc, GlobalSummaryState>(
                builder: (context, state) {
                  final confirmed = state.summary.confirmed.value != null
                      ? formatValue(
                          int.parse(state.summary.confirmed.value),
                        )
                      : '';
                  final deaths = state.summary.deaths.value != null
                      ? formatValue(
                          int.parse(state.summary.deaths.value),
                        )
                      : '';
                  final recovered = state.summary.recovered.value != null
                      ? formatValue(
                          int.parse(state.summary.recovered.value),
                        )
                      : '';
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
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
                            SummaryNumber(
                              value: recovered,
                              title: 'Recovered',
                              color: recoveredColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
