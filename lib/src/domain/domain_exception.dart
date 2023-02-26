import 'package:ire_common/src/error/base_exception.dart';

class DomainException extends BaseException {
  DomainException([String? reason, String? devReason])
      : super(reason ?? 'Internal error',
            '[Domain] ${devReason ?? 'Internal error'} (in production: "$reason")');
}
