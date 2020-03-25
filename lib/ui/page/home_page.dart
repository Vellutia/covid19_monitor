import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/global_summary_bloc.dart';
import '../../locator.dart';
import '../../repository/global_summary_repository.dart';
import '../widget/home_page/country_card.dart';
import '../widget/home_page/summary_card.dart';

class HomePage extends StatelessWidget {
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
          title: Text('Coronavirus Monitor'),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: RefreshIndicator(
          onRefresh: () async => onRefresh(context),
          child: ListView(
            children: [
              SummaryCard(
                formatValue: formatValue,
              ),
              CountryCard(
                formatValue: formatValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
