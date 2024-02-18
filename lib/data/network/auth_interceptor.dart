import 'package:dio/dio.dart';
import 'package:wenia_test/core/config.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final apiKey = config.apiKey;
    options.queryParameters['x_cg_demo_api_key'] = apiKey;
    handler.next(options);
  }
}
