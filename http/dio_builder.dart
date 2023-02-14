import 'package:dio/dio.dart';
import 'dio_builder/stub.dart'
    if (dart.library.io) './dio_builder/native.dart'
    if (dart.library.html) './dio_builder/web.dart';

abstract class DioBuilder {
  Dio build({
    required String baseUrl,
    void Function(RequestOptions options, RequestInterceptorHandler handler)?
        onRequest,
    void Function(
            Response<dynamic> response, ResponseInterceptorHandler handler)?
        onResponse,
    void Function(DioError error, ErrorInterceptorHandler handler)? onError,
  });

  factory DioBuilder() => createBuilder();
}
