import 'dart:async';

import 'package:dio/dio.dart';
import '../task.dart';

class IreClientResult<T> extends Result<T> {
  final Headers headers;

  IreClientResult({
    required this.headers,
    required super.value,
    super.message,
  });
}

class IreClientTask<T> extends AbstractTask<IreClientResult<T>, T> {
  IreClientTask(super.fn);
  // IreClientTask(Future<IreClientResult<T>> Function() fn) : super(fn);
}
