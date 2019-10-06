import '../../reducers/index.dart';

class CounterModel {
  CounterState state;
  Function() onIncreaseCounter;
  Function() onDecreaseCounter;
  Function() onResetCounter;

  CounterModel(
      {this.state,
      this.onIncreaseCounter,
      this.onDecreaseCounter,
      this.onResetCounter});
}
