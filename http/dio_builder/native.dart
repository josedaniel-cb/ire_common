import 'package:dio/dio.dart';
import 'package:latin_library/common/http/dio_builder.dart';
import 'package:latin_library/common/http/dio_builder/native/cookies_handler.dart';

class DioForNativeBuilder implements DioBuilder {
  final _cookiesHandler = CookiesHandler();

  @override
  Dio build({
    required String baseUrl,
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioError, ErrorInterceptorHandler)? onError,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      followRedirects: false,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _cookiesHandler.setRequestHeaders(options);
        if (onRequest == null) {
          return handler.next(options);
        }
        return onRequest(options, handler);
      },
      onResponse: (response, handler) {
        _cookiesHandler.saveResponseHeaders(response);
        if (onResponse == null) {
          return handler.next(response);
        }
        return onResponse(response, handler);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) {
        if (onError == null) {
          return handler.next(error);
        }
        return onError(error, handler);
      },
    ));

    return dio;
  }
}

DioBuilder createBuilder() => DioForNativeBuilder();
