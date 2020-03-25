part of 'per_country_bloc.dart';

abstract class PerCountryEvent extends Equatable {
  const PerCountryEvent();
}

class InitPerCountry extends PerCountryEvent {
  @override
  List<Object> get props => [];
}

class ChangePerCountry extends PerCountryEvent {
  final String country;

  const ChangePerCountry(this.country);

  @override
  List<Object> get props => [country];
}
