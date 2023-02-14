abstract class BaseException implements Exception {
  final String reason;

  BaseException(this.reason);

  @override
  String toString() {
    return reason;
  }
}
