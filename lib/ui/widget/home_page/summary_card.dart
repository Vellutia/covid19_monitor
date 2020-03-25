import 'package:covid19_monitor/bloc/global_summary_bloc.dart';
import 'package:covid19_monitor/ui/widget/home_page/summary_cases.dart';
import 'package:covid19_monitor/ui/widget/home_page/summary_number.dart';
import 'package:covid19_monitor/ui/widget/home_page/summary_piechart.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryCard extends StatelessWidget {
  final String Function(int) formatValue;

  const SummaryCard({
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
          child: BlocBuilder<GlobalSummaryBloc, GlobalSummaryState>(
            builder: (context, state) {
              final cases = state is GlobalSummaryLoaded
                  ? formatValue(int.parse(state.summary.confirmed.value) +
                      int.parse(state.summary.deaths.value) +
                      int.parse(state.summary.recovered.value))
                  : '';
              final confirmed = state is GlobalSummaryLoaded
                  ? formatValue(
                      int.parse(state.summary.confirmed.value),
                    )
                  : '';
              final deaths = state is GlobalSummaryLoaded
                  ? formatValue(
                      int.parse(state.summary.deaths.value),
                    )
                  : '';
              final recovered = state is GlobalSummaryLoaded
                  ? formatValue(
                      int.parse(state.summary.recovered.value),
                    )
                  : '';
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Stack(
                        alignment: Alignment.center,
                        children: [
                          SummaryPiechart(
                            numbers: [
                              state is GlobalSummaryLoaded
                                  ? state.summary.confirmed.value
                                  : '1.0',
                              state is GlobalSummaryLoaded
                                  ? state.summary.deaths.value
                                  : '1.0',
                              state is GlobalSummaryLoaded
                                  ? state.summary.recovered.value
                                  : '1.0',
                            ],
                          ),
                          SummaryCases(
                            cases: cases,
                            constraints: constraints,
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  Text(
                    'Last checked: ${state is GlobalSummaryLoaded ? state.time : ''}\nData source: ${state is GlobalSummaryLoaded ? state.summary.source : ''}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: labelColor),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
