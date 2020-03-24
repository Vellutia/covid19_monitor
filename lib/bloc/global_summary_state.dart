part of 'global_summary_bloc.dart';

class GlobalSummaryState extends Equatable {
  final String time;
  final int cases;
  final GlobalSummary summary;

  const GlobalSummaryState(
    this.time,
    this.cases,
    this.summary,
  );

  @override
  List<Object> get props => [time, cases, summary];
}
