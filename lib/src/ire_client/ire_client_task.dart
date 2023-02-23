import 'dart:async';

import 'package:dio/dio.dart';
// import '../task.dart';

// class IreClientResult<T> extends Result<T> {
//   final Headers headers;

//   IreClientResult({
//     required this.headers,
//     required super.value,
//     super.message,
//   });
// }

// class IreClientTask<T> extends Task<T> {
//   IreClientTask(Future<IreClientResult<T>> Function() fn) : super(fn);

//   @override
//   Future<IreClientResult<T>> get result async {
//     return super.result as IreClientResult<T>;
//   }
// }

class IreClientResult<T> {
  final Headers headers;
  final T value;
  final String? message;

  IreClientResult({
    required this.headers,
    required this.value,
    this.message,
  });
}

class IreClientTask<T> {
  final Future<IreClientResult<T>> Function() _fn;

  IreClientTask(this._fn);

  Future<IreClientResult<T>> get result async {
    return await this._fn();
  }

  Future<T> get value async {
    return (await this._fn()).value;
  }
}
