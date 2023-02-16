import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:latin_library/common/error/domain_exception.dart';
import 'package:latin_library/common/error/http_client_exception.dart';
import 'package:latin_library/common/error/repository_exception.dart';
import 'package:latin_library/common/result.dart';

export 'package:latin_library/common/result.dart';

class DomainTask<T> extends Task<T> {
  // Convert fn to Task
  DomainTask(Future<Result<T>> Function() fn) : super(() => _try(fn));

  static Future<Result<T>> _try<T>(Future<Result<T>> Function() fn) async {
    try {
      return await fn();
    } catch (e, s) {
      if (e is HttpClientException || e is RepositoryException) {
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
