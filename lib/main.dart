import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

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
      ],
      child: MaterialApp(
        title: 'Coronavirus Monitor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
          accentTextTheme: TextTheme(
            subtitle1: TextStyle(color: Color(0xFFff4d00)),
            subtitle2: TextStyle(color: Color(0xFF29a19c)),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
