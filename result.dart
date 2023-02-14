class Result<T> {
  String? message;
  T value;

  Result({this.message, required this.value});

  // factory Result.value(T value) {
  //   return Result<T>(message: null, value: value);
  // }
}

class Task<T> {
  final Future<Result<T>> Function() _fn;

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
}
