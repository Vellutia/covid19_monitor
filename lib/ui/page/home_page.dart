import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/global_summary_bloc.dart';
import '../../locator.dart';
import '../../repository/cases_repository.dart';
import '../../repository/global_summary_repository.dart';
import '../../utils/app_style.dart';
import '../widget/home_page/summary_cases.dart';
import '../widget/home_page/summary_number.dart';
import '../widget/home_page/summary_piechart.dart';

class HomePage extends StatelessWidget {
  void onRefresh(BuildContext context) async {
    await Future.wait([
      locator<CasesRepository>().fetchCases(),
      locator<GlobalSummaryRepository>().fetchGlobalSummary(),
    ]).then((value) {
      String time = DateFormat('EEE d MMM, kk:mm:ss').format(DateTime.now());
      BlocProvider.of<GlobalSummaryBloc>(context)
          .add(RefreshGlobalSummary(time, value[0], value[1]));
    });
  }

  String formatValue(int value) => NumberFormat.simpleCurrency(decimalDigits: 0)
      .format(value)
      .replaceAll('\$', '');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Coronavirus Monitor'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: RefreshIndicator(
          onRefresh: () async => onRefresh(context),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12.0,
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
                        final cases =
                            state.cases != null ? formatValue(state.cases) : '';
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
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: LayoutBuilder(
                                builder: (context, constraints) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SummaryPiechart(
                                      numbers: [
                                        state.summary.confirmed.value ?? '1.0',
                                        state.summary.deaths.value ?? '1.0',
                                        state.summary.recovered.value ?? '1.0',
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                              'Last checked: ${state.time ?? ''}\nData source: ${state.summary.source ?? ''}',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
