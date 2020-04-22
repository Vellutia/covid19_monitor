import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:covid19_monitor/bloc/feature/global_summary_bloc.dart';
import 'package:covid19_monitor/model/global_summary_model.dart';
import 'package:covid19_monitor/model/value_model.dart';
import 'package:covid19_monitor/repository/global_summary_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

class MockHydratedBlocStorage extends Mock implements HydratedBlocStorage {}

class MockHydratedBlocDelegate extends Mock implements HydratedBlocDelegate {}

class MockGlobalSummaryRepository extends Mock
    implements GlobalSummaryRepository {}

void main() {
  MockHydratedBlocDelegate delegate;
  MockHydratedBlocStorage storage;
  MockGlobalSummaryRepository mockGlobalSummaryRepository;

  final time = 'time';

  final summary = GlobalSummary(
    confirmed: Value(value: ''),
    deaths: Value(value: ''),
    recovered: Value(value: ''),
    source: '',
  );

  setUp(() {
    delegate = MockHydratedBlocDelegate();
    BlocSupervisor.delegate = delegate;
    storage = MockHydratedBlocStorage();

    when(delegate.storage).thenReturn(storage);

    mockGlobalSummaryRepository = MockGlobalSummaryRepository();
  });

  group(
    'initialState HydratedBloc',
    () {
      GlobalSummaryBloc globalSummaryBloc;

      setUp(() {
        globalSummaryBloc = GlobalSummaryBloc(
          globalSummaryRepository: mockGlobalSummaryRepository,
        );
      });

      tearDown(() {
        globalSummaryBloc?.close();
      });

      test(
        'initialState should return GlobalSummaryInitial() when fromJson returns null',
        () {
          when<dynamic>(storage.read('GlobalSummaryBloc')).thenReturn(null);
          expect(globalSummaryBloc.initialState, GlobalSummaryInitial());
          verify<dynamic>(storage.read('GlobalSummaryBloc')).called(2);
        },
      );

      test(
        'initialState should return GlobalSummaryLoaded() when fromJson returns summary',
        () {
          when<dynamic>(storage.read('GlobalSummaryBloc'))
              .thenReturn(json.encode({
            'time': time,
            'summary': summary.toJson(),
          }));
          expect(globalSummaryBloc.initialState,
              GlobalSummaryLoaded(time, summary));
          verify<dynamic>(storage.read('GlobalSummaryBloc')).called(2);
        },
      );

      group(
        'clear',
        () {
          test(
            'calls delete on storage',
            () async {
              await globalSummaryBloc.clear();
              verify(storage.delete('GlobalSummaryBloc')).called(1);
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
        'emits [GlobalSummaryLoaded()] when RefreshGlobalSummary() is added',
        build: () async {
          return GlobalSummaryBloc(
            globalSummaryRepository: mockGlobalSummaryRepository,
          );
        },
        act: (bloc) => bloc.add(RefreshGlobalSummary(time, summary)),
        expect: [GlobalSummaryLoaded(time, summary)],
      );

      blocTest(
        'emits [GlobalSummaryLoaded()] when InitGlobalSummary() is added',
        build: () async {
          when(mockGlobalSummaryRepository.fetchGlobalSummary())
              .thenAnswer((realInvocation) async => summary);
          return GlobalSummaryBloc(
            globalSummaryRepository: mockGlobalSummaryRepository,
          );
        },
        act: (bloc) => bloc.add(InitGlobalSummary(time)),
        expect: [GlobalSummaryLoaded(time, summary)],
      );
    },
  );
}
