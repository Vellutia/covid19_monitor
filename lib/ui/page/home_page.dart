import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_monitor/bloc/data/position_bloc.dart';
import 'package:covid19_monitor/bloc/feature/daily_update_bloc.dart';
import 'package:covid19_monitor/bloc/feature/per_country_bloc.dart';
import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:covid19_monitor/ui/widget/home_page/daily_card.dart';
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
              DailyCard(
                formatValue: formatValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
