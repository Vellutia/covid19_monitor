import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_monitor/bloc/data/position_bloc.dart';
import 'package:covid19_monitor/bloc/feature/daily_update_bloc.dart';
import 'package:covid19_monitor/bloc/feature/per_country_bloc.dart';
import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:covid19_monitor/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/feature/global_summary_bloc.dart';
import '../../locator.dart';
import '../../repository/global_summary_repository.dart';
import '../widget/home_page/country_card.dart';
import '../widget/home_page/summary_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
        // initialScrollOffset: BlocProvider.of<PositionBloc>(context).state ?? 0.0,
        );
    // _controller.addListener(
    //   () => BlocProvider.of<PositionBloc>(context)
    //       .add(_controller.position.pixels),
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onRefresh(
      BuildContext context, PerCountryLoaded perCountryLoaded) async {
    await Future.wait([
      locator<GlobalSummaryRepository>().fetchGlobalSummary(),
      locator<PerCountryRepository>().fetchPerCountry(perCountryLoaded.country),
    ]).then((value) {
      String time = DateFormat('EEE d MMM, kk:mm:ss').format(DateTime.now());
      BlocProvider.of<GlobalSummaryBloc>(context)
          .add(RefreshGlobalSummary(time, value[0]));
      BlocProvider.of<PerCountryBloc>(context)
          .add(RefreshPerCountry(perCountryLoaded.country, value[1]));
    });
  }

  void jumpToTop() => _controller.animateTo(
        _controller.position.minScrollExtent,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
      );

  String formatValue(int value) => NumberFormat.simpleCurrency(decimalDigits: 0)
      .format(value)
      .replaceAll('\$', '');

  @override
  Widget build(BuildContext context) {
    final globalSummaryState =
        BlocProvider.of<GlobalSummaryBloc>(context).state;
    final perCountryState = BlocProvider.of<PerCountryBloc>(context).state;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          elevation: 0.0,
          highlightElevation: 0.0,
          child: Icon(Icons.arrow_upward),
          onPressed: () => jumpToTop(),
        ),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              SizedBox(
                height: 28.0,
                child: Image.asset('asset/icon/launcher.png'),
              ),
              RichText(
                text: TextSpan(
                  text: ' COVID',
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    TextSpan(
                      text: '19',
                      style: Theme.of(context).accentTextTheme.headline6,
                    ),
                  ],
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            if (globalSummaryState is GlobalSummaryLoaded &&
                perCountryState is PerCountryLoaded) {
              onRefresh(context, perCountryState);
            }
          },
          child: ListView(
            controller: _controller,
            children: [
              SummaryCard(
                formatValue: formatValue,
              ),
              CountryCard(
                formatValue: formatValue,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        8.0,
                        16.0,
                        12.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Daily Updates',
                              style:
                                  Theme.of(context).accentTextTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              final confirmedIcon =
                                  (index != (state.dailyUpdates.length - 1))
                                      ? state.dailyUpdates[index]
                                                  .deltaConfirmedDetail.total >
                                              state.dailyUpdates[index + 1]
                                                  .deltaConfirmedDetail.total
                                          ? Icons.trending_up
                                          : Icons.trending_down
                                      : Icons.trending_up;
                              final deathsIcon =
                                  (index != (state.dailyUpdates.length - 1))
                                      ? state.dailyUpdates[index].deaths.total >
                                              state.dailyUpdates[index + 1]
                                                  .deaths.total
                                          ? Icons.trending_up
                                          : Icons.trending_down
                                      : Icons.trending_up;
                              final reportDate = DateFormat('EEE d MMM')
                                  .format(state.dailyUpdates[index].reportDate);
                              final casesChina = formatValue(
                                  state.dailyUpdates[index].mainlandChina);
                              final casesOthers = formatValue(
                                  state.dailyUpdates[index].otherLocations);
                              final confirmed = formatValue(state
                                  .dailyUpdates[index]
                                  .deltaConfirmedDetail
                                  .total);
                              final deaths = formatValue(
                                  state.dailyUpdates[index].deaths.total);

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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                            group:
                                                                autoSizeGroup,
                                                            style: TextStyle(
                                                                color:
                                                                    confirmedColor),
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
                                                                color:
                                                                    deathsColor),
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
                                                    .copyWith(
                                                        color: labelColor),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
