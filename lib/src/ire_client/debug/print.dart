import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void printRequest(RequestOptions requestOptions) {
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

void printResponse(Response response) {
  if (kDebugMode) {
    print('[🌐][🛬] HEADERS: ${jsonEncode(response.headers.map)}');
    if (response.data != null) {
      try {
        final json = jsonEncode(response.data);
        print('[🌐][🛬] DATA: $json');
      } catch (e) {
        print('[🌐][🛬] DATA: ${response.data}');
      }
    }
  }
}
