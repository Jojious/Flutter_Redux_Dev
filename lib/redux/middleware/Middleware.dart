import 'package:redux/redux.dart';

class CounterMiddleware implements MiddlewareClass {
  @override
  void call(Store store, action, next) {
    // TODO: implement call
    print(action);
    next(action);
  }
}
