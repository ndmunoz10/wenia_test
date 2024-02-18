import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wenia_test/data/network/auth_interceptor.dart';

@module
abstract class NetworkModule {
  final _prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
  );

  Dio get dio {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 90);
    dio.options.contentType = 'application/json';
    dio.interceptors.addAll([
      AuthInterceptor(),
      _prettyDioLogger,
    ]);

    return dio;
  }
}
