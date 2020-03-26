part of 'daily_update_bloc.dart';

abstract class DailyUpdateState extends Equatable {
  const DailyUpdateState();
}

class DailyUpdateInitial extends DailyUpdateState {
  @override
  List<Object> get props => [];
}
