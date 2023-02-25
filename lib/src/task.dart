import 'dart:async';

abstract class AbstractTask<ResultT extends Result<T>, T> {
  final FutureOr<ResultT> Function() _fn;

  AbstractTask(this._fn);

  Future<T> get value async {
    return (await _fn()).value;
  }

  Future<ResultT> get result async {
    return await _fn();
  }
}

// class SimpleTask<T> extends AbstractTask<Result<T>, T> {
//   SimpleTask(super.fn);
// }

typedef Task<T> = AbstractTask<Result<T>, T>;

class Result<T> {
  String? message;
  T value;

  Result({this.message, required this.value});
}
