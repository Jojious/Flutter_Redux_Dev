import 'package:redux/redux.dart';

class CounterState {
  int counter;

  CounterState(this.counter);
}

enum counterAction { Increment, Decrement, ResetCounter }

final counterReducer = combineReducers<CounterState>([
  TypedReducer<CounterState, counterAction>(setCounter),
  TypedReducer<CounterState, counterAction>(resetCounter)
]);

CounterState setCounter(CounterState state, dynamic action) {
  if (action == counterAction.Increment) {
    state.counter++;
    return state;
  } else if (action == counterAction.Decrement) {
    state.counter--;
    return state;
  }
  return state;
}

CounterState resetCounter(CounterState state, dynamic action) {
  if (action == counterAction.ResetCounter) {
    state.counter = 0;
    return state;
  }
  return state;
}
