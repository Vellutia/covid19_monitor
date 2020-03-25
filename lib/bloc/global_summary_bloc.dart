import 'dart:async';

import 'package:covid19_monitor/model/value_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/global_summary_model.dart';
import '../repository/global_summary_repository.dart';

part 'global_summary_event.dart';
part 'global_summary_state.dart';

class GlobalSummaryBloc extends Bloc<GlobalSummaryEvent, GlobalSummaryState> {
  final GlobalSummaryRepository globalSummaryRepository;

  GlobalSummaryBloc({
    @required this.globalSummaryRepository,
  });

  @override
  GlobalSummaryState get initialState => GlobalSummaryInitial();

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
}
