import 'dart:io';

import 'package:dio/dio.dart';

import 'base_exception.dart';

String _handleResponseError(DioError e) {
  final response = e.response;
  if (response != null) {
    final data = response.data;
    if (data is Map<String, dynamic> && data['message'] != null) {
      var message = data['message'];
      if (message is List) {
        message = message[0];
      }
      return message.toString();
    }
    final statusCode = response.statusCode;
    final statusMessage = response.statusMessage;
    if (statusCode != null && statusMessage != null) {
      return '($statusCode) $statusMessage';
    }
  }
  return 'Http response error';
}

String _handleError(DioError e) {
  switch (e.type) {
    case DioErrorType.response:
      return _handleResponseError(e);
    case DioErrorType.connectTimeout:
      return 'Url was opened timeout';
    case DioErrorType.sendTimeout:
      return 'Url was sent timeout';
    case DioErrorType.receiveTimeout:
      return 'Url was received timeout';
    case DioErrorType.cancel:
      break;
    case DioErrorType.other:
      if (e.error is SocketException) {
        return 'Connection error';
      }
      return 'An unexpected connection error occurred';
  }
  return 'This line will be never reached';
}

class HttpClientException extends BaseException {
  HttpClientException._(String reason) : super(reason);

  factory HttpClientException.dio(DioError e) {
    final message = _handleError(e);
    return HttpClientException._(message);
  }
}
