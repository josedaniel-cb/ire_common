import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'debug/print.dart';
import 'ire_client_exception.dart';
import 'dio_builder.dart';
import 'ire_client_task.dart';
import '../error/repository_exception.dart';
import '../result.dart';

typedef JsonMap = Map<String, dynamic>;

typedef SerializerFn<T> = T Function(dynamic);

class IreClient {
  final Dio _dio;

  IreClient({
    required String baseUrl,
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioError, ErrorInterceptorHandler)? onError,
  }) : _dio = DioBuilder().build(
          baseUrl: baseUrl,
          onRequest: (options, handler) {
            printRequest(options);
            if (onRequest == null) {
              return handler.next(options);
            }
            return onRequest(options, handler);
          },
          onResponse: (response, handler) {
            printResponse(response);
            if (onResponse == null) {
              return handler.next(response);
            }
            return onResponse(response, handler);
          },
          onError: (error, handler) {
            if (error.response != null) {
              printResponse(error.response!);
            }
            if (onError == null) {
              return handler.next(error);
            }
            return onError(error, handler);
          },
        );

  Future<IreClientResult<T>> tryRequest<T>({
    required Future<Response<dynamic>> Function() request,
    // required SerializerFn<T> serializer,
    required T Function(Object) serializer,
  }) async {
    try {
      final response = await request();
      response.headers;
      final message = response.data!['message'];
      final data = response.data!['data'];
      // https://stackoverflow.com/a/68512449/11026079
      if (serializer.runtimeType.toString().endsWith('void')) {
        return IreClientResult(
          headers: response.headers,
          value: null as T,
          message: message,
        );
      }
      return IreClientResult(
        headers: response.headers,
        value: serializer(data),
        message: message,
      );
    } catch (e, s) {
      if (kDebugMode) {
        print('[HttpClient] Error: $e');
        print('[HttpClient] Stacktrace:\n$s');
      }

      if (e is DioError) {
        throw IreClientException.dio(e);
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

  Task<T> postForm<T>({
    required String path,
    required SerializerFn<T> serializer,
    required FormData data,
  }) {
    return Task(() => tryRequest(
          request: () => _dio.post(path, data: data),
          serializer: serializer,
        ));
  }
}

extension SerializerFnExtensions<T> on T Function(Map<String, dynamic>) {
  SerializerFn<List<T>> toListSerializer() {
    return (value) => (value as List).map((item) => this(item)).toList();
  }

  SerializerFn<T> toSerializer() {
    return (value) => this(value);
  }
}
