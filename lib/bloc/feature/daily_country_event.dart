part of 'daily_country_bloc.dart';

abstract class DailyCountryEvent extends Equatable {
  final String date;

  const DailyCountryEvent(this.date);

  @override
  List<Object> get props => [date];
}

class InitDailyCountry extends DailyCountryEvent {
  const InitDailyCountry(String date) : super(date);
}
