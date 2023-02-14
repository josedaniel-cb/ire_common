import 'package:dio/dio.dart';
import 'package:dio/adapter_browser.dart';
import 'package:latin_library/common/http/dio_builder.dart';

class DioForWebBuilder implements DioBuilder {
  @override
  Dio build({
    required String baseUrl,
    void Function(RequestOptions, RequestInterceptorHandler)? onRequest,
    void Function(Response<dynamic>, ResponseInterceptorHandler)? onResponse,
    void Function(DioError, ErrorInterceptorHandler)? onError,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    final adapter = BrowserHttpClientAdapter();
    adapter.withCredentials = true;
    dio.httpClientAdapter = adapter;

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: onRequest,
      onResponse: onResponse,
      onError: onError,
    ));

    return dio;
  }
}

DioBuilder createBuilder() => DioForWebBuilder();
