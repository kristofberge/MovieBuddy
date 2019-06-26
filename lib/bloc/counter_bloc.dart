import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _value = 0;

  @override
  CounterState get initialState => InitialCounterState();

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncrementCounter) {
      yield LoadingState();
      _value = await _increment(_value);
      yield CounterIncremented(_value);
    }
  }

  Future<int> _increment(int value) async {
    return Future.delayed(Duration(seconds: 1), () => value + 1);
  }
}
