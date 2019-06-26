import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CounterState extends Equatable {
  CounterState([List props = const []]) : super(props);
}

class InitialCounterState extends CounterState {}

class LoadingState extends CounterState {}

class  CounterIncremented extends CounterState {
  final int value;

  CounterIncremented(this.value) : super([value]);
}