part of 'daily_update_bloc.dart';

abstract class DailyUpdateEvent extends Equatable {
  const DailyUpdateEvent();
}

class InitDailyUpdate extends DailyUpdateEvent {
  @override
  List<Object> get props => [];
}

class RefreshDailyUpdate extends DailyUpdateEvent {
  final List<DailyUpdate> dailyUpdate;

  const RefreshDailyUpdate(this.dailyUpdate);

  @override
  List<Object> get props => [dailyUpdate];
}
