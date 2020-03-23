import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/global_summary_bloc.dart';
import '../../locator.dart';
import '../../repository/global_summary_repository.dart';
import '../../utils/app_style.dart';
import '../widget/summary_number.dart';

class HomePage extends StatelessWidget {
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
          onRefresh: () async {
            await Future.value(
              locator<GlobalSummaryRepository>().fetchGlobalSummary(),
            ).then((value) {
              String time =
                  DateFormat('EEE d MMM, kk:mm:ss').format(DateTime.now());
              BlocProvider.of<GlobalSummaryBloc>(context)
                  .add(RefreshGlobalSummary(time, value));
            });
          },
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
                      builder: (context, state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20.0,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SummaryNumber(
                                  value: state.summary.confirmed.value ?? '',
                                  title: 'Confirmed',
                                  color: confirmedColor,
                                ),
                                SummaryNumber(
                                  value: state.summary.deaths.value ?? '',
                                  title: 'Deaths',
                                  color: deathsColor,
                                ),
                                SummaryNumber(
                                  value: state.summary.recovered.value ?? '',
                                  title: 'Recovered',
                                  color: recoveredColor,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Last updated: ${state.time}\nData source: ${state.summary.source}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: labelColor),
                          ),
                        ],
                      ),
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
