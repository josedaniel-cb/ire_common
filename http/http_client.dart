import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:latin_library/common/http/dio_builder.dart';
import 'package:latin_library/common/error/http_client_exception.dart';
import 'package:latin_library/common/error/repository_exception.dart';
import 'package:latin_library/common/result.dart';

export 'package:latin_library/common/result.dart';

typedef JsonMap = Map<String, dynamic>;
// typedef SerializerFn<T> = T Function(JsonMap);
typedef SerializerFn<T> = T Function(dynamic);

extension SerializerFnExtensions<T> on T Function(Map<String, dynamic>) {
  List<T> Function(dynamic) toListSerializer() {
    return (value) => (value as List).map((item) => this(item)).toList();
  }

  T Function(dynamic) toSerializer() {
    return (value) => this(value);
  }
}

void _printRequest(RequestOptions requestOptions) {
  if (kDebugMode) {
    print('[🌐][🚀] METHOD: ${requestOptions.method}');
    print('[🌐][🚀] URL: ${requestOptions.uri}');
    print('[🌐][🚀] HEADERS: ${jsonEncode(requestOptions.headers)}');
    if (requestOptions.data != null) {
      try {
        print('[🌐][🚀] DATA: ${jsonEncode(requestOptions.data)}');
      } catch (e) {
        print('[🌐][🚀] DATA: ${requestOptions.data}');
      }
    }
  }
}

void _printResponse(Response response) {
  if (kDebugMode) {
    print('[🌐][🛬] HEADERS: ${jsonEncode(response.headers.map)}');
    if (response.data != null) {
      try {
        print('[🌐][🛬] DATA: ${jsonEncode(response.data)}');
      } catch (e) {
        print('[🌐][🛬] DATA: ${response.data}');
      }
    }
  }
}

class HttpClient {
  final Dio _dio;

  HttpClient({
    required String baseUrl,
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioError, ErrorInterceptorHandler)? onError,
  }) : _dio = DioBuilder().build(
          baseUrl: baseUrl,
          onRequest: (options, handler) {
            _printRequest(options);
            if (onRequest == null) {
              return handler.next(options);
            }
            return onRequest(options, handler);
          },
          onResponse: (response, handler) {
            _printResponse(response);
            if (onResponse == null) {
              return handler.next(response);
            }
            return onResponse(response, handler);
          },
          onError: (error, handler) {
            if (error.response != null) {
              _printResponse(error.response!);
            }
            if (onError == null) {
              return handler.next(error);
            }
            return onError(error, handler);
          },
        );

  Future<Result<T>> tryRequest<T>({
    required Future<Response<dynamic>> Function() request,
    // required SerializerFn<T> serializer,
    required T Function(Object) serializer,
  }) async {
    try {
      final response = await request();
      final message = response.data!['message'];
      final data = response.data!['data'];
      // https://stackoverflow.com/a/68512449/11026079
      if (serializer.runtimeType.toString().endsWith('void')) {
        return Result(message: message, value: null as T);
      }
      return Result(message: message, value: serializer(data));
    } catch (e, s) {
      if (kDebugMode) {
        print('[HttpClient] Error: $e');
        print('[HttpClient] Stacktrace:\n$s');
      }

      if (e is DioError) {
        throw HttpClientException.dio(e);
      }

      throw RepositoryException();
    }
  }

  Task<T> get<T>({
    required String path,
    required SerializerFn<T> serializer,
    Map<String, dynamic>? queryParameters,
  }) {
    return Task(() => tryRequest(
          request: () => _dio.get(path, queryParameters: queryParameters),
          serializer: serializer,
        ));
  }

  Task<T> post<T>({
    required String path,
    required SerializerFn<T> serializer,
    required JsonMap data,
  }) {
    return Task(() => tryRequest(
          request: () => _dio.post(path, data: data),
          serializer: serializer,
        ));
  }

  Task<T> put<T>({
    required String path,
    required SerializerFn<T> serializer,
    required JsonMap data,
  }) {
    return Task(() => tryRequest(
          request: () => _dio.put(path, data: data),
          serializer: serializer,
        ));
  }

  Task<T> putForm<T>({
    required String path,
    required SerializerFn<T> serializer,
    required FormData data,
  }) {
    return Task(() => tryRequest(
          request: () => _dio.put(path, data: data),
          serializer: serializer,
        ));
  }
}
