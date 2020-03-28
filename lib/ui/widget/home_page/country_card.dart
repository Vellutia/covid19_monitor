import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../bloc/feature/country_list_bloc.dart';
import '../../../bloc/feature/per_country_bloc.dart';
import '../../../utils/app_style.dart';
import '../../../utils/ui_helper.dart';
import 'country_search.dart';
import 'summary_number.dart';

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
        vertical: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Per Country Data',
                      style: Theme.of(context).accentTextTheme.subtitle1,
                    ),
                  ),
                ),
                BlocBuilder<CountryListBloc, CountryListState>(
                  builder: (context, state) => state is CountryListLoaded
                      ? InkWell(
                          onTap: () => showSearch(
                            context: context,
                            delegate: CountrySearch(state.countryList),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Change Country',
                                  style: Theme.of(context)
                                      .accentTextTheme
                                      .subtitle1,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.0,
                                  color: accentColor,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Offstage(),
                ),
              ],
            ),
          ),
          verticalSpaceTiny,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Card(
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
          ),
        ],
      ),
    );
  }
}
