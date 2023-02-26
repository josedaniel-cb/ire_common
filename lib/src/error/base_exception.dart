import 'package:flutter/foundation.dart';

// abstract class BaseException implements Exception {
abstract class BaseException {
  final String reason;
  final String? devReason;

  BaseException(this.reason, [this.devReason]);

  @override
  String toString() {
    if (kReleaseMode) {
      return reason;
    }
    return devReason != null ? devReason! : reason;
  }
}
