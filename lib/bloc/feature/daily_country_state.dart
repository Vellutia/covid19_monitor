part of 'daily_country_bloc.dart';

abstract class DailyCountryState extends Equatable {
  const DailyCountryState();
}

class DailyCountryInitial extends DailyCountryState {
  @override
  List<Object> get props => [];
}

class DailyCountryLoading extends DailyCountryState {
  @override
  List<Object> get props => [];
}

class DailyCountryLoaded extends DailyCountryState {
  final List<DailyCountry> dailyCountry;

  const DailyCountryLoaded(this.dailyCountry);

  @override
  List<Object> get props => [dailyCountry];
}
