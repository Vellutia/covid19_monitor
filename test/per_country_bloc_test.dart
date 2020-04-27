import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:covid19_monitor/bloc/feature/per_country_bloc.dart';
import 'package:covid19_monitor/model/per_country_model.dart';
import 'package:covid19_monitor/model/value_model.dart';
import 'package:covid19_monitor/repository/per_country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

class MockHydratedBlocStorage extends Mock implements HydratedBlocStorage {}

class MockHydratedBlocDelegate extends Mock implements HydratedBlocDelegate {}

class MockPerCountryRepository extends Mock implements PerCountryRepository {}

void main() {
  MockHydratedBlocDelegate delegate;
  MockHydratedBlocStorage storage;
  MockPerCountryRepository mockPerCountryRepository;

  final country = 'country';
  final perCountry = PerCountry(
    confirmed: Value(value: ''),
    deaths: Value(value: ''),
    recovered: Value(value: ''),
    lastUpdate: DateTime(2020, 1, 10),
  );

  setUp(() {
    delegate = MockHydratedBlocDelegate();
    BlocSupervisor.delegate = delegate;
    storage = MockHydratedBlocStorage();

    when(delegate.storage).thenReturn(storage);

    mockPerCountryRepository = MockPerCountryRepository();
  });

  group(
    'initialState HydratedBloc',
    () {
      PerCountryBloc perCountryBloc;

      setUp(() {
        perCountryBloc = PerCountryBloc(
          perCountryRepository: mockPerCountryRepository,
        );
      });

      tearDown(() {
        perCountryBloc?.close();
      });

      test(
        'initialState should return PerCountryInitial() when fromJson returns null',
        () {
          when<dynamic>(storage.read('PerCountryBloc')).thenReturn(null);
          expect(perCountryBloc.initialState, PerCountryInitial());
          verify<dynamic>(storage.read('PerCountryBloc')).called(2);
        },
      );

      test(
        'initialState should return PerCountryLoaded() when fromJson returns perCountry',
        () {
          when<dynamic>(storage.read('PerCountryBloc')).thenReturn(json.encode({
            'country': country,
            'perCountry': perCountry.toJson(),
          }));
          expect(perCountryBloc.initialState,
              PerCountryLoaded(country, perCountry));
          verify<dynamic>(storage.read('PerCountryBloc')).called(2);
        },
      );

      group(
        'clear',
        () {
          test(
            'calls delete on storage',
            () async {
              await perCountryBloc.clear();
              verify(storage.delete('PerCountryBloc')).called(1);
            },
          );
        },
      );
    },
  );

  group(
    'mapEventToState',
    () {
      PerCountryBloc perCountryBloc;

      setUp(() {
        perCountryBloc = PerCountryBloc(
          perCountryRepository: mockPerCountryRepository,
        );
      });

      tearDown(() {
        perCountryBloc?.close();
      });

      blocTest(
        'emits [PerCountryLoaded()] when ChangePerCountry() is added',
        build: () async {
          when(mockPerCountryRepository.fetchPerCountry(any))
              .thenAnswer((realInvocation) async => perCountry);
          return perCountryBloc;
        },
        act: (bloc) => bloc.add(ChangePerCountry(country)),
        expect: [PerCountryLoaded(country, perCountry)],
      );
    },
  );
}
