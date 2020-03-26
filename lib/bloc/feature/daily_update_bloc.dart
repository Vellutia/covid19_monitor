import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_monitor/model/daily_update_model.dart';
import 'package:equatable/equatable.dart';

part 'daily_update_event.dart';
part 'daily_update_state.dart';

class DailyUpdateBloc extends Bloc<DailyUpdateEvent, DailyUpdateState> {
  @override
  DailyUpdateState get initialState => DailyUpdateInitial();

  @override
  Stream<DailyUpdateState> mapEventToState(
    DailyUpdateEvent event,
  ) async* {
    
  }
}
