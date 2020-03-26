import 'dart:async';

import 'package:covid19_monitor/model/value_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/global_summary_model.dart';
import '../../repository/global_summary_repository.dart';

part 'global_summary_event.dart';
part 'global_summary_state.dart';

class GlobalSummaryBloc
    extends HydratedBloc<GlobalSummaryEvent, GlobalSummaryState> {
  final GlobalSummaryRepository globalSummaryRepository;

  GlobalSummaryBloc({
    @required this.globalSummaryRepository,
  });

  @override
  GlobalSummaryState get initialState =>
      super.initialState ?? GlobalSummaryInitial();

  @override
  Stream<GlobalSummaryState> mapEventToState(
    GlobalSummaryEvent event,
  ) async* {
    if (event is RefreshGlobalSummary) {
      yield GlobalSummaryLoaded(
        event.time,
        event.summary,
      );
    } else {
      final summary = await globalSummaryRepository.fetchGlobalSummary();
      yield GlobalSummaryLoaded(
        event.time,
        summary,
      );
    }
  }

  @override
  GlobalSummaryState fromJson(Map<String, dynamic> json) {
    final time = json['time'] as String;
    final summary = GlobalSummary.fromJson(json['summary']);
    try {
      return GlobalSummaryLoaded(
        time,
        summary,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(GlobalSummaryState state) {
    final time = (state as GlobalSummaryLoaded).time;
    final summary = (state as GlobalSummaryLoaded).summary.toJson();
    try {
      return {
        'time': time,
        'summary': summary,
      };
    } catch (_) {
      return null;
    }
  }
}
