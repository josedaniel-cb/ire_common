import 'dart:async';

import 'package:dio/dio.dart';
import '../result.dart';

class IreClientResult<T> extends Result<T> {
  final Headers headers;

  IreClientResult({
    required this.headers,
    required super.value,
    super.message,
  });
}

class IreClientTask<T> extends Task<T> {
  IreClientTask(Future<IreClientResult<T>> Function() fn) : super(fn);
}
