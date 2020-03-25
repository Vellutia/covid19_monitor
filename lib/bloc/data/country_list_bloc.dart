import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_monitor/model/country_list_model.dart';
import 'package:covid19_monitor/repository/country_list_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'country_list_event.dart';
part 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final CountryListRepository countryListRepository;

  CountryListBloc({
    @required this.countryListRepository,
  });

  @override
  CountryListState get initialState => CountryListInitial();

  @override
  Stream<CountryListState> mapEventToState(
    CountryListEvent event,
  ) async* {
    final countryList = await countryListRepository.fetchCountryList();
    yield CountryListLoaded(countryList);
  }
}
