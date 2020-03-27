import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_monitor/model/daily_update_model.dart';
import 'package:covid19_monitor/repository/daily_update_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'daily_update_event.dart';
part 'daily_update_state.dart';

class DailyUpdateBloc extends Bloc<DailyUpdateEvent, DailyUpdateState> {
  final DailyUpdateRepository dailyUpdateRepository;

  DailyUpdateBloc({
    @required this.dailyUpdateRepository,
  });

  @override
  DailyUpdateState get initialState => DailyUpdateInitial();

  @override
  Stream<DailyUpdateState> mapEventToState(
    DailyUpdateEvent event,
  ) async* {
    if (event is RefreshDailyUpdate) {
      yield DailyUpdateLoaded(
        event.dailyUpdate,
      );
    } else {
      final dailyUpdate = await dailyUpdateRepository.fetchDailyUpdate();
      yield DailyUpdateLoaded(
        dailyUpdate,
      );
    }
  }
}
