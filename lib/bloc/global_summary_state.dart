part of 'global_summary_bloc.dart';

class GlobalSummaryState extends Equatable {
  final String time;
  final GlobalSummary summary;

  const GlobalSummaryState(this.time, this.summary);

  @override
  List<Object> get props => [time, summary];
}
