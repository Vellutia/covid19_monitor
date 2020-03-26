import 'package:covid19_monitor/bloc/data/position_bloc.dart';
import 'package:covid19_monitor/utils/app_style.dart';
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
  // ScrollController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = ScrollController(
  //     initialScrollOffset: BlocProvider.of<PositionBloc>(context).state ?? 0.0,
  //   );
  //   _controller.addListener(
  //     () => BlocProvider.of<PositionBloc>(context)
  //         .add(_controller.position.pixels),
  //   );
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void onRefresh(BuildContext context) async {
    await Future.value(
      locator<GlobalSummaryRepository>().fetchGlobalSummary(),
    ).then((value) {
      String time = DateFormat('EEE d MMM, kk:mm:ss').format(DateTime.now());
      BlocProvider.of<GlobalSummaryBloc>(context)
          .add(RefreshGlobalSummary(time, value));
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
          onRefresh: () async => onRefresh(context),
          child: ListView(
            // controller: _controller,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
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
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder: (context, index) => Divider(
                        height: 1.5,
                        color: scaffoldBackgroundColor,
                      ),
                      itemBuilder: (context, index) => Material(
                        color: cardColor,
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(title: Text('$index')),
                        ),
                      ),
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
