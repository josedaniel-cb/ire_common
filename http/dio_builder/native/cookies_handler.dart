import 'dart:io';

import 'package:dio/dio.dart';

class CookiesHandler {
  final Map<String, Cookie> _cookies = {};

  String _headerValue = '';

  add(List<Cookie> cookies) {
    for (final cookie in cookies) {
      _cookies[cookie.name] = cookie;
    }
    _headerValue = _cookies.entries
        .map((entry) => '${entry.value.name}=${entry.value}')
        .join(';');
  }

  void saveResponseHeaders(Response response) {
    // Look for incoming cookies
    final setCookieHeaders = response.headers['set-cookie'];
    if (setCookieHeaders != null) {
      final incomingCookies =
          setCookieHeaders.map((e) => Cookie.fromSetCookieValue(e)).toList();

      // Save incoming cookies
      add(incomingCookies);
    }
  }

  RequestOptions setRequestHeaders(RequestOptions options) {
    if (_headerValue.isNotEmpty) {
      options.headers['cookie'] = _headerValue;
    }
    final csrfToken = _cookies['csrftoken']?.value;
    if (csrfToken != null) {
      options.headers['X-CSRFTOKEN'] = csrfToken;
    }
    return options;
  }
}
