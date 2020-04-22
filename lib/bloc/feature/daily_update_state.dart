part of 'daily_update_bloc.dart';

abstract class DailyUpdateState extends Equatable {
  const DailyUpdateState();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class DailyUpdateInitial extends DailyUpdateState {}

class DailyUpdateLoaded extends DailyUpdateState {
  final List<DailyUpdate> dailyUpdates;

  const DailyUpdateLoaded(this.dailyUpdates);

  @override
  List<Object> get props => [dailyUpdates];
}
