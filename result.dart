import 'dart:async';

class Result<T> {
  String? message;
  T value;

  Result({this.message, required this.value});

  // factory Result.value(T value) {
  //   return Result<T>(message: null, value: value);
  // }
}

class Task<T> {
  final FutureOr<Result<T>> Function() _fn;

  Task(this._fn);

  Future<T> get value async {
    return (await _fn()).value;
  }

  Future<String?> get message async {
    return (await _fn()).message;
  }

  Future<Result<T>> get result async {
    return await _fn();
  }

  // static Task<R> pipe<T, R>(
  //   Future<Result<T>> Function() fn,
  //   FutureOr<R> Function(T) pipeFn,
  // ) {
  //   return Task<R>(() async {
  //     final firstResult = await fn();
  //     final pipeResult = Result(
  //       message: firstResult.message,
  //       value: await pipeFn(firstResult.value),
  //     );
  //     return pipeResult;
  //   });
  // }

  // static Task<T> fromValue<T>(T value) {
  //   return Task(() => Result(value: value));
  // }
}
