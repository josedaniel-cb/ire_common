import 'dart:async';

import 'package:flutter/foundation.dart';

import 'domain_exception.dart';
import '../ire_client/ire_client_exception.dart';
import '../error/repository_exception.dart';
import '../task.dart';

class DomainTask<T> extends Task<T> {
  // Convert fn to Task
  DomainTask(Future<Result<T>> Function() fn) : super(() => _try(fn));

  static Future<Result<T>> _try<T>(Future<Result<T>> Function() fn) async {
    try {
      return await fn();
    } catch (e, s) {
      if (e is IreClientException || e is RepositoryException) {
        rethrow;
      }

      if (kDebugMode) {
        print('[DomainTask] Error: $e');
        print('[DomainTask] Stacktrace:\n$s');
      }

      throw DomainException();
    }
  }
}
