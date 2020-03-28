import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/feature/daily_country_bloc.dart';
import '../widget/daily_country_page/daily_country_card.dart';

class DailyCountryPage extends StatelessWidget {
  final String Function(int) formatValue;

  const DailyCountryPage({
    Key key,
    this.formatValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DailyCountryBloc, DailyCountryState>(
        builder: (context, state) {
          if (state is DailyCountryLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: ListView.builder(
                itemCount: state.dailyCountry.length,
                itemBuilder: (context, index) {
                  final country = state.dailyCountry[index].admin2 != null &&
                          state.dailyCountry[index].provinceState != null
                      ? '${state.dailyCountry[index].admin2}, ${state.dailyCountry[index].provinceState}, ${state.dailyCountry[index].countryRegion}'
                      : state.dailyCountry[index].admin2 != null
                          ? '${state.dailyCountry[index].admin2}, ${state.dailyCountry[index].countryRegion}'
                          : state.dailyCountry[index].provinceState != null
                              ? '${state.dailyCountry[index].provinceState}, ${state.dailyCountry[index].countryRegion}'
                              : '${state.dailyCountry[index].countryRegion}';
                  final confirmed = formatValue(
                    int.parse(state.dailyCountry[index].confirmed),
                  );
                  final deaths = formatValue(
                    int.parse(state.dailyCountry[index].deaths),
                  );

                  return DailyCountryCard(
                    country: country,
                    confirmed: confirmed,
                    deaths: deaths,
                  );
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
