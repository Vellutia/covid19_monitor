part of 'per_country_bloc.dart';

abstract class PerCountryEvent extends Equatable {
  const PerCountryEvent();
}

class InitPerCountry extends PerCountryEvent {
  @override
  List<Object> get props => [];
}

class RefreshPerCountry extends PerCountryEvent {
  final String country;
  final PerCountry perCountry;

  const RefreshPerCountry(this.country, this.perCountry);

  @override
  List<Object> get props => [country, perCountry];
}

class ChangePerCountry extends PerCountryEvent {
  final String country;

  const ChangePerCountry(this.country);

  @override
  List<Object> get props => [country];
}
