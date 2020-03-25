import 'package:covid19_monitor/bloc/feature/global_summary_bloc.dart';
import 'package:covid19_monitor/bloc/feature/per_country_bloc.dart';
import 'package:covid19_monitor/ui/widget/home_page/summary_number.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:covid19_monitor/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
              child: BlocBuilder<PerCountryBloc, PerCountryState>(
                builder: (context, state) {
                  final country =
                      state is PerCountryLoaded ? state.country : '';
                  final lastUpdated = state is PerCountryLoaded
                      ? DateFormat('EEE d MMM, kk:mm:ss')
                          .format(state.perCountry.lastUpdate)
                      : '';
                  final confirmed = state is PerCountryLoaded
                      ? formatValue(
                          int.parse(state.perCountry.confirmed.value),
                        )
                      : '';
                  final deaths = state is PerCountryLoaded
                      ? formatValue(
                          int.parse(state.perCountry.deaths.value),
                        )
                      : '';
                  final recovered = state is PerCountryLoaded
                      ? formatValue(
                          int.parse(state.perCountry.recovered.value),
                        )
                      : '';
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '$country',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'Last updated: $lastUpdated',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: labelColor),
                          ),
                        ],
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
                          SummaryNumber(
                            value: recovered,
                            title: 'Recovered',
                            color: recoveredColor,
                          ),
                        ],
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
