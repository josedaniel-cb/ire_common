import 'base_exception.dart';

class RepositoryException extends BaseException {
  RepositoryException([String? reason, String? devReason])
      : super(reason ?? 'Internal error',
            '[Repository] ${devReason ?? 'Internal error'} (in production: "$reason")');
}
