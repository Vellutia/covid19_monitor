import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/global_summary_model.dart';
import '../repository/global_summary_repository.dart';

part 'global_summary_event.dart';
part 'global_summary_state.dart';

class GlobalSummaryBloc extends Bloc<GlobalSummaryEvent, GlobalSummaryState> {
  final GlobalSummaryRepository globalSummaryRepository;

  GlobalSummaryBloc(this.globalSummaryRepository);

  @override
  GlobalSummaryState get initialState => GlobalSummaryState(
      '',
      GlobalSummary(
        confirmed: Value(value: ''),
        deaths: Value(value: ''),
        recovered: Value(value: ''),
        source: '',
      ));

  @override
  Stream<GlobalSummaryState> mapEventToState(
    GlobalSummaryEvent event,
  ) async* {
    if (event is RefreshGlobalSummary) {
      yield GlobalSummaryState(event.time, event.summary);
    } else {
      final summary = await Future.value(
        globalSummaryRepository.fetchGlobalSummary(),
      );
      yield GlobalSummaryState(event.time, summary);
    }
  }
}
