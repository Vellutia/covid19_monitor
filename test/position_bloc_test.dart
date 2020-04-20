import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:covid19_monitor/bloc/data/position_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';

class MockHydratedBlocStorage extends Mock implements HydratedBlocStorage {}

class MockHydratedBlocDelegate extends Mock implements HydratedBlocDelegate {}

void main() {
  MockHydratedBlocDelegate delegate;
  MockHydratedBlocStorage storage;

  setUp(() {
    delegate = MockHydratedBlocDelegate();
    BlocSupervisor.delegate = delegate;
    storage = MockHydratedBlocStorage();

    when(delegate.storage).thenReturn(storage);
  });

  group(
    'initialState HydratedBloc',
    () {
      PositionBloc positionBloc;

      setUp(() {
        positionBloc = PositionBloc();
      });

      test(
        'initialState should return 0.0 when fromJson returns null',
        () {
          when<dynamic>(storage.read('PositionBloc')).thenReturn(null);
          expect(positionBloc.initialState, 0.0);
          verify<dynamic>(storage.read('PositionBloc')).called(2);
        },
      );

      test(
        'initialState should return 0.5 when fromJson returns 0.5',
        () {
          when<dynamic>(storage.read('PositionBloc'))
              .thenReturn(json.encode({'position': 0.5}));
          expect(positionBloc.initialState, 0.5);
          verify<dynamic>(storage.read('PositionBloc')).called(2);
        },
      );

      group(
        'clear',
        () {
          test(
            'calls delete on storage',
            () async {
              await positionBloc.clear();
              verify(storage.delete('PositionBloc')).called(1);
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
        'emits [0.2, 0.3] when [0.2, 0.3] is added',
        build: () async {
          return PositionBloc();
        },
        act: (bloc) async {
          bloc.add(0.2);
          bloc.add(0.3);
        },
        expect: [0.2, 0.3],
      );
    },
  );
}
