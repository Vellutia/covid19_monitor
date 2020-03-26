part of 'country_list_bloc.dart';

abstract class CountryListState extends Equatable {
  const CountryListState();
}

class CountryListInitial extends CountryListState {
  @override
  List<Object> get props => [];
}

class CountryListLoaded extends CountryListState {
  final CountryList countryList;

  const CountryListLoaded(this.countryList);

  @override
  List<Object> get props => [countryList];
}
