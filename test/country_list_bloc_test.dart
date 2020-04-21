import 'package:bloc_test/bloc_test.dart';
import 'package:covid19_monitor/bloc/feature/country_list_bloc.dart';
import 'package:covid19_monitor/model/country_list_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:covid19_monitor/repository/country_list_repository.dart';

class MockCountryListRepository extends Mock implements CountryListRepository {}

void main() {
  MockCountryListRepository mockCountryListRepository;

  setUp(() {
    mockCountryListRepository = MockCountryListRepository();
  });

  group(
    'initialState',
    () {
      blocTest(
        'emits [] when nothing is added',
        build: () async {
          return CountryListBloc(
            countryListRepository: mockCountryListRepository,
          );
        },
        expect: [],
      );

      blocTest(
        'emits [CountryListInitial] when nothing is added and skip: 0',
        build: () async {
          return CountryListBloc(
            countryListRepository: mockCountryListRepository,
          );
        },
        skip: 0,
        expect: [CountryListInitial()],
      );
    },
  );

  group(
    'mapEventToState',
    () {
      final countryList = CountryList(
        countries: [
          Country(name: 'US'),
          Country(name: 'Indonesia'),
        ],
      );

      blocTest(
        'emits [CountryListLoaded()] when CountryListEvent() is added',
        build: () async {
          when(mockCountryListRepository.fetchCountryList())
              .thenAnswer((realInvocation) async => countryList);
          return CountryListBloc(
            countryListRepository: mockCountryListRepository,
          );
        },
        act: (bloc) => bloc.add(CountryListEvent()),
        expect: [CountryListLoaded(countryList)],
      );
    },
  );
}
