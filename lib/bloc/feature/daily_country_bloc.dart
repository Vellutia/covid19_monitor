import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/daily_country_model.dart';
import '../../repository/daily_country_repository.dart';

part 'daily_country_event.dart';
part 'daily_country_state.dart';

class DailyCountryBloc extends Bloc<DailyCountryEvent, DailyCountryState> {
  final DailyCountryRepository dailyCountryRepository;

  DailyCountryBloc({
    @required this.dailyCountryRepository,
  });

  @override
  DailyCountryState get initialState => DailyCountryInitial();

  @override
  Stream<DailyCountryState> mapEventToState(
    DailyCountryEvent event,
  ) async* {
    yield DailyCountryLoading();
    final dailyCountry =
        await dailyCountryRepository.fetchDailyCountry(event.date);
    yield DailyCountryLoaded(dailyCountry);
  }
}
