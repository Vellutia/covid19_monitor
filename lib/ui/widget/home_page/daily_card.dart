import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_monitor/bloc/feature/daily_update_bloc.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:covid19_monitor/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DailyCard extends StatelessWidget {
  final String Function(int) formatValue;

  const DailyCard({
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
                      'Daily Updates',
                      style: Theme.of(context).accentTextTheme.subtitle1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceSmall,
          BlocBuilder<DailyUpdateBloc, DailyUpdateState>(
            builder: (context, state) {
              if (state is DailyUpdateLoaded) {
                final autoSizeGroup = AutoSizeGroup();

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.dailyUpdates.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1.5,
                    color: scaffoldBackgroundColor,
                  ),
                  itemBuilder: (context, index) {
                    final confirmedIcon = (index !=
                            (state.dailyUpdates.length - 1))
                        ? state.dailyUpdates[index].deltaConfirmedDetail.total >
                                state.dailyUpdates[index + 1]
                                    .deltaConfirmedDetail.total
                            ? Icons.trending_up
                            : Icons.trending_down
                        : Icons.trending_up;
                    final deathsIcon =
                        (index != (state.dailyUpdates.length - 1))
                            ? state.dailyUpdates[index].deaths.total >
                                    state.dailyUpdates[index + 1].deaths.total
                                ? Icons.trending_up
                                : Icons.trending_down
                            : Icons.trending_up;
                    final reportDate = DateFormat('EEE d MMM')
                        .format(state.dailyUpdates[index].reportDate);
                    final casesChina =
                        formatValue(state.dailyUpdates[index].mainlandChina);
                    final casesOthers =
                        formatValue(state.dailyUpdates[index].otherLocations);
                    final confirmed = formatValue(
                        state.dailyUpdates[index].deltaConfirmedDetail.total);
                    final deaths =
                        formatValue(state.dailyUpdates[index].deaths.total);

                    return Material(
                      color: cardColor,
                      child: InkWell(
                        onTap: () {},
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: accentColor,
                              ),
                              horizontalSpaceMedium,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('$reportDate'),
                                    verticalSpaceSmall,
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                confirmedIcon,
                                                color: accentColor,
                                              ),
                                              Expanded(
                                                child: AutoSizeText(
                                                  ' Confirmed: $confirmed',
                                                  maxLines: 1,
                                                  group: autoSizeGroup,
                                                  style: TextStyle(
                                                      color: confirmedColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        horizontalSpaceTiny,
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                deathsIcon,
                                                color: accentColor,
                                              ),
                                              Expanded(
                                                child: AutoSizeText(
                                                  ' Deaths: $deaths',
                                                  maxLines: 1,
                                                  group: autoSizeGroup,
                                                  style: TextStyle(
                                                      color: deathsColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpaceSmall,
                                    Text(
                                      'Total $casesChina cases on China and $casesOthers on the other location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(color: labelColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Offstage();
            },
          ),
        ],
      ),
    );
  }
}
