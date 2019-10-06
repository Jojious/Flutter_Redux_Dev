import 'package:flutter/material.dart';
import 'package:flutter_redux_app/redux/viewmodel/counterModel/counterModel.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './redux/reducers/index.dart';
import './redux/viewmodel/index.dart';
import './redux/middleware/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store store = Store<CounterState>(
    counterReducer,
    middleware: [CounterMiddleware()],
    initialState: CounterState(0),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CounterState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Redux no.1"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreConnector<CounterState, CounterModel>(
                builder: (context, CounterModel model) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      model.state.counter.toString(),
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              );
            }, converter: (store) {
              return CounterModel(state: store.state);
            }),
            Align(alignment: Alignment.bottomRight, child: increaseButton()),
            Align(alignment: Alignment.bottomLeft, child: decreaseButton()),
            Align(alignment: Alignment.bottomCenter, child: resetButton()),
          ],
        ));
  }
}

Widget increaseButton() {
  return Container(
      padding: EdgeInsets.all(16),
      child: StoreConnector<CounterState, CounterModel>(
          converter: (store) => CounterModel(
              state: store.state,
              onIncreaseCounter: () => store.dispatch(counterAction.Increment)),
          builder: (context, CounterModel model) => FloatingActionButton(
                onPressed: model.onIncreaseCounter,
                child: Icon(Icons.add),
              )));
}

Widget decreaseButton() {
  return Container(
      padding: EdgeInsets.all(16),
      child: StoreConnector<CounterState, CounterModel>(
          converter: (store) {
            return CounterModel(
                state: store.state,
                onDecreaseCounter: () =>
                    store.dispatch(counterAction.Decrement));
          },
          builder: (context, CounterModel model) => FloatingActionButton(
                onPressed: model.onDecreaseCounter,
                child: Icon(Icons.remove),
              )));
}

Widget resetButton() {
  return Container(
      padding: EdgeInsets.all(16),
      child: StoreConnector<CounterState, CounterModel>(
          converter: (store) {
            return CounterModel(
                state: store.state,
                onResetCounter: () =>
                    store.dispatch(counterAction.ResetCounter));
          },
          builder: (context, CounterModel model) => FloatingActionButton(
                onPressed: model.onResetCounter,
                child: Icon(Icons.refresh),
              )));
}
