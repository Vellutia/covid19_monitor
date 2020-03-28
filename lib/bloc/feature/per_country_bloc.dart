import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/per_country_model.dart';
import '../../repository/per_country_repository.dart';

part 'per_country_event.dart';
part 'per_country_state.dart';

class PerCountryBloc extends HydratedBloc<PerCountryEvent, PerCountryState> {
  final PerCountryRepository perCountryRepository;

  PerCountryBloc({
    @required this.perCountryRepository,
  });

  @override
  PerCountryState get initialState => super.initialState ?? PerCountryInitial();

  @override
  Stream<PerCountryState> mapEventToState(
    PerCountryEvent event,
  ) async* {
    if (event is ChangePerCountry) {
      final perCountry =
          await perCountryRepository.fetchPerCountry(event.country);

      yield PerCountryLoaded(event.country, perCountry);
    } else {
      if (state is PerCountryLoaded) {
        final curState = (state as PerCountryLoaded);
        final perCountry =
            await perCountryRepository.fetchPerCountry('${curState.country}');

        yield PerCountryLoaded('${curState.country}', perCountry);
      } else {
        final perCountry =
            await perCountryRepository.fetchPerCountry('Indonesia');

        yield PerCountryLoaded('Indonesia', perCountry);
      }
    }
  }

  @override
  PerCountryState fromJson(Map<String, dynamic> json) {
    final country = json['country'] as String;
    final perCountry = PerCountry.fromJson(json['perCountry']);
    try {
      return PerCountryLoaded(
        country,
        perCountry,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(PerCountryState state) {
    final country = (state as PerCountryLoaded).country;
    final perCountry = (state as PerCountryLoaded).perCountry.toJson();
    try {
      return {
        'country': country,
        'perCountry': perCountry,
      };
    } catch (_) {
      return null;
    }
  }
}
