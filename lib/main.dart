import 'package:covid19_monitor/bloc/feature/daily_update_bloc.dart';
import 'package:covid19_monitor/repository/country_list_repository.dart';
import 'package:covid19_monitor/repository/daily_update_repository.dart';
import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:covid19_monitor/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

import 'bloc/feature/country_list_bloc.dart';
import 'bloc/data/position_bloc.dart';
import 'bloc/feature/global_summary_bloc.dart';
import 'bloc/feature/per_country_bloc.dart';
import 'bloc_delegate.dart';
import 'locator.dart';
import 'repository/global_summary_repository.dart';
import 'ui/page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setupLocator();

  BlocSupervisor.delegate =
      SimpleBlocDelegate(await HydratedBlocStorage.getInstance());

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalSummaryBloc>(
          create: (context) {
            String time =
                DateFormat('EEE d MMM, kk:mm:ss').format(DateTime.now());
            return GlobalSummaryBloc(
              globalSummaryRepository: locator<GlobalSummaryRepository>(),
            )..add(InitGlobalSummary(time));
          },
        ),
        BlocProvider<PerCountryBloc>(
          create: (context) => PerCountryBloc(
            perCountryRepository: locator<PerCountryRepository>(),
          )..add(InitPerCountry()),
        ),
        BlocProvider<CountryListBloc>(
          create: (context) => CountryListBloc(
            countryListRepository: locator<CountryListRepository>(),
          )..add(CountryListEvent()),
        ),
        BlocProvider<DailyUpdateBloc>(
          create: (context) => DailyUpdateBloc(
            dailyUpdateRepository: locator<DailyUpdateRepository>(),
          )..add(InitDailyUpdate()),
        ),
        BlocProvider<PositionBloc>(
          create: (context) => PositionBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'COVID19 Monitor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          cardColor: cardColor,
          cursorColor: accentColor,
          accentTextTheme: TextTheme(
            headline6: TextStyle(color: accentColor),
            subtitle1: TextStyle(color: accentColor),
            subtitle2: TextStyle(color: accentColor),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
