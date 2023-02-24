import 'dart:async';

abstract class Task<ResultT extends Result<T>, T> {
  final FutureOr<ResultT> Function() _fn;

  Task(this._fn);

  Future<T> get value async {
    return (await _fn()).value;
  }

  Future<ResultT> get result async {
    return await _fn();
  }
}

class Result<T> {
  String? message;
  T value;

  Result({this.message, required this.value});
}
