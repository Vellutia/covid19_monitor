import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/daily_update_model.dart';
import '../../repository/daily_update_repository.dart';

part 'daily_update_event.dart';
part 'daily_update_state.dart';

class DailyUpdateBloc extends HydratedBloc<DailyUpdateEvent, DailyUpdateState> {
  final DailyUpdateRepository dailyUpdateRepository;

  DailyUpdateBloc({
    @required this.dailyUpdateRepository,
  });

  @override
  DailyUpdateState get initialState =>
      super.initialState ?? DailyUpdateInitial();

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

  @override
  DailyUpdateState fromJson(Map<String, dynamic> json) {
    final dailyUpdates = List<DailyUpdate>.from(
        json["dailyUpdates"].map((x) => DailyUpdate.fromJson(x)));
    try {
      return DailyUpdateLoaded(
        dailyUpdates,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(DailyUpdateState state) {
    final dailyUpdates = List<dynamic>.from(
      (state as DailyUpdateLoaded).dailyUpdates.map((x) => x.toJson()),
    );
    try {
      return {
        'dailyUpdates': dailyUpdates,
      };
    } catch (_) {
      return null;
    }
  }
}
