part of 'global_summary_bloc.dart';

abstract class GlobalSummaryEvent extends Equatable {
  final String time;

  const GlobalSummaryEvent(this.time);

  @override
  List<Object> get props => [time];
}

class InitGlobalSummary extends GlobalSummaryEvent {
  InitGlobalSummary(String time) : super(time);
}

class RefreshGlobalSummary extends GlobalSummaryEvent {
  final int cases;
  final GlobalSummary summary;

  const RefreshGlobalSummary(
    String time,
    this.cases,
    this.summary,
  ) : super(time);

  @override
  List<Object> get props => [cases, summary];
}
