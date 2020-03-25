import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid19_monitor/model/per_country_model.dart';
import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'per_country_event.dart';
part 'per_country_state.dart';

class PerCountryBloc extends Bloc<PerCountryEvent, PerCountryState> {
  final PerCountryRepository perCountryRepository;

  PerCountryBloc({
    @required this.perCountryRepository,
  });

  @override
  PerCountryState get initialState => PerCountryInitial();

  @override
  Stream<PerCountryState> mapEventToState(
    PerCountryEvent event,
  ) async* {
    if (event is ChangePerCountry) {
      final perCountry =
          await perCountryRepository.fetchPerCountry(event.country);

      yield PerCountryLoaded(event.country, perCountry);
    } else {
      final perCountry =
          await perCountryRepository.fetchPerCountry('Indonesia');

      yield PerCountryLoaded('Indonesia', perCountry);
    }
  }
}
