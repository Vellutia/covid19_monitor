import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';

class PositionBloc extends HydratedBloc<double, double> {
  @override
  double get initialState => super.initialState ?? 0.0;

  @override
  Stream<double> mapEventToState(
    double event,
  ) async* {
    yield event;
  }

  @override
  double fromJson(Map<String, dynamic> json) {
    try {
      return json['position'] as double;
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(double state) {
    try {
      return {'position': state};
    } catch (_) {
      return null;
    }
  }
}
