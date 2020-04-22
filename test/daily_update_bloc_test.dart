import 'package:bloc_test/bloc_test.dart';
import 'package:covid19_monitor/bloc/feature/daily_update_bloc.dart';
import 'package:covid19_monitor/model/daily_update_model.dart';
import 'package:covid19_monitor/repository/daily_update_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

class MockHydratedBlocStorage extends Mock implements HydratedBlocStorage {}

class MockHydratedBlocDelegate extends Mock implements HydratedBlocDelegate {}

class MockDailyUpdateRepository extends Mock implements DailyUpdateRepository {}

void main() {
  MockHydratedBlocDelegate delegate;
  MockHydratedBlocStorage storage;
  MockDailyUpdateRepository mockDailyUpdateRepository;

  final dailyUpdate = [
    DailyUpdate(
      deaths: Details(total: 0),
      deltaConfirmedDetail: Details(total: 0),
      mainlandChina: 0,
      otherLocations: 0,
      reportDate: DateTime.now(),
    ),
    DailyUpdate(
      deaths: Details(total: 1),
      deltaConfirmedDetail: Details(total: 1),
      mainlandChina: 1,
      otherLocations: 1,
      reportDate: DateTime.now(),
    ),
  ];

  setUp(() {
    delegate = MockHydratedBlocDelegate();
    BlocSupervisor.delegate = delegate;
    storage = MockHydratedBlocStorage();

    when(delegate.storage).thenReturn(storage);

    mockDailyUpdateRepository = MockDailyUpdateRepository();
  });

  group(
    'initialState HydratedBloc',
    () {
      DailyUpdateBloc dailyUpdateBloc;

      setUp(() {
        dailyUpdateBloc = DailyUpdateBloc(
          dailyUpdateRepository: mockDailyUpdateRepository,
        );
      });

      test(
        'initialState should return DailyUpdateInitial() when fromJson returns null',
        () {
          when<dynamic>(storage.read('DailyUpdateBloc')).thenReturn(null);
          expect(dailyUpdateBloc.initialState, DailyUpdateInitial());
          verify<dynamic>(storage.read('DailyUpdateBloc')).called(2);
        },
      );

      test(
        'initialState should return DailyUpdateLoaded() when fromJson returns dailyUpdate',
        () {},
      );

      group(
        'clear',
        () {
          test(
            'calls delete on storage',
            () async {
              await dailyUpdateBloc.clear();
              verify(storage.delete('DailyUpdateBloc')).called(1);
            },
          );
        },
      );
    },
  );

  group(
    'mapEventToState',
    () {
      blocTest(
        'emits [DailyUpdateLoaded()] when RefreshDailyUpdate() is added',
        build: () async {
          return DailyUpdateBloc(
            dailyUpdateRepository: mockDailyUpdateRepository,
          );
        },
        act: (bloc) => bloc.add(RefreshDailyUpdate(dailyUpdate)),
        expect: [DailyUpdateLoaded(dailyUpdate)],
      );

      blocTest(
        'emits [DailyUpdateLoaded()] when InitDailyUpdate() is added',
        build: () async {
          when(mockDailyUpdateRepository.fetchDailyUpdate())
              .thenAnswer((realInvocation) async => dailyUpdate);
          return DailyUpdateBloc(
            dailyUpdateRepository: mockDailyUpdateRepository,
          );
        },
        act: (bloc) => bloc.add(InitDailyUpdate()),
        expect: [DailyUpdateLoaded(dailyUpdate)],
      );
    },
  );
}
