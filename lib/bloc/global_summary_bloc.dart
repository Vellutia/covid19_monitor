import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/global_summary_model.dart';
import '../repository/cases_repository.dart';
import '../repository/global_summary_repository.dart';

part 'global_summary_event.dart';
part 'global_summary_state.dart';

class GlobalSummaryBloc extends Bloc<GlobalSummaryEvent, GlobalSummaryState> {
  final GlobalSummaryRepository globalSummaryRepository;
  final CasesRepository casesRepository;

  GlobalSummaryBloc({
    @required this.globalSummaryRepository,
    @required this.casesRepository,
  });

  @override
  GlobalSummaryState get initialState => GlobalSummaryState(
        null,
        null,
        GlobalSummary(
          confirmed: Value(value: null),
          deaths: Value(value: null),
          recovered: Value(value: null),
          source: null,
        ),
      );

  @override
  Stream<GlobalSummaryState> mapEventToState(
    GlobalSummaryEvent event,
  ) async* {
    if (event is RefreshGlobalSummary) {
      yield GlobalSummaryState(
        event.time,
        event.cases,
        event.summary,
      );
    } else {
      final datas = await Future.wait([
        casesRepository.fetchCases(),
        globalSummaryRepository.fetchGlobalSummary(),
      ]);
      yield GlobalSummaryState(
        event.time,
        datas[0],
        datas[1],
      );
    }
  }
}
