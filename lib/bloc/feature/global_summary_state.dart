part of 'global_summary_bloc.dart';

abstract class GlobalSummaryState extends Equatable {
  const GlobalSummaryState();
}

class GlobalSummaryInitial extends GlobalSummaryState {
  @override
  List<Object> get props => [];
}

class GlobalSummaryLoaded extends GlobalSummaryState {
  final String time;
  final GlobalSummary summary;

  const GlobalSummaryLoaded(this.time, this.summary);

  @override
  List<Object> get props => [time, summary];
}
