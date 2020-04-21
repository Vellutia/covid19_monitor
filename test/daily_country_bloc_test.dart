import 'package:bloc_test/bloc_test.dart';
import 'package:covid19_monitor/bloc/feature/daily_country_bloc.dart';
import 'package:covid19_monitor/model/daily_country_model.dart';
import 'package:covid19_monitor/repository/daily_country_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDailyCountryRepository extends Mock
    implements DailyCountryRepository {}

void main() {
  MockDailyCountryRepository mockDailyCountryRepository;

  setUp(() {
    mockDailyCountryRepository = MockDailyCountryRepository();
  });

  group(
    'initialState',
    () {
      blocTest(
        'emits [] when nothing is added',
        build: () async {
          return DailyCountryBloc(
            dailyCountryRepository: mockDailyCountryRepository,
          );
        },
        expect: [],
      );

      blocTest(
        'emits [DailyCountryInitial()] when nothing is added and skip: 0',
        build: () async {
          return DailyCountryBloc(
            dailyCountryRepository: mockDailyCountryRepository,
          );
        },
        skip: 0,
        expect: [DailyCountryInitial()],
      );
    },
  );

  group(
    'mapEventToState',
    () {
      final dailyCountry = [
        DailyCountry(
          admin2: '0',
          confirmed: '0',
          countryRegion: '0',
          deaths: '0',
          provinceState: '0',
        ),
        DailyCountry(
          admin2: '1',
          confirmed: '1',
          countryRegion: '1',
          deaths: '1',
          provinceState: '1',
        ),
      ];

      blocTest(
        'emits [DailyCountryLoading(), DailyCountryLoaded()] when DailyCountryEvent() is added',
        build: () async {
          when(mockDailyCountryRepository.fetchDailyCountry(any))
              .thenAnswer((realInvocation) async => dailyCountry);
          return DailyCountryBloc(
            dailyCountryRepository: mockDailyCountryRepository,
          );
        },
        act: (bloc) => bloc.add(InitDailyCountry('')),
        expect: [DailyCountryLoading(), DailyCountryLoaded(dailyCountry)],
      );
    },
  );
}
