part of 'per_country_bloc.dart';

abstract class PerCountryState extends Equatable {
  const PerCountryState();
}

class PerCountryInitial extends PerCountryState {
  @override
  List<Object> get props => [];
}

class PerCountryLoaded extends PerCountryState {
  final String country;
  final PerCountry perCountry;

  const PerCountryLoaded(this.country, this.perCountry);

  @override
  List<Object> get props => [country, perCountry];
}
