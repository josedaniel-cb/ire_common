import 'package:ire_common/src/error/base_exception.dart';

class DomainException extends BaseException {
  DomainException([String? message])
      : super('[Domain] ${message ?? 'Internal error'}');
}
