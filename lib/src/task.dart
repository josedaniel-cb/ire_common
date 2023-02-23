import 'dart:async';

// abstract class AbstractTask<R> {
//   final FutureOr<R> Function() _fn;

//   AbstractTask(this._fn);

//   Future<R> get result async {
//     return await _fn();
//   }
// }

class Result<T> {
  String? message;
  T value;

  Result({this.message, required this.value});
}

class Task<T> {
  final FutureOr<Result<T>> Function() _fn;

  Task(this._fn);

  Future<T> get value async {
    return (await _fn()).value;
  }

  Future<Result<T>> get result async {
    return await _fn();
  }
}
