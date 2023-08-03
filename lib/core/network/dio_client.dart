import 'package:assignment_app/core/network/interceptor/token_interceptor.dart';
import 'package:assignment_app/core/values/strings.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'interceptor/error_interceptor.dart';

class DioProvider {
  final Dio _dio;

  DioProvider() : _dio = Dio() {
    _dio.options.baseUrl = AppStrings.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.responseType = ResponseType.json;
    _dio.interceptors.addAll([
      TokenInterceptor(),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
      RetryInterceptor(
        dio: _dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
      DioCacheInterceptor(
        options: CacheOptions(
          store: MemCacheStore(),
          policy: CachePolicy.request,
          hitCacheOnErrorExcept: [401, 403],
          priority: CachePriority.normal,
          maxStale: const Duration(days: 7),
        ),
      ),
      ErrorInterceptor(),
    ]);
  }

  Dio get client => _dio;
}
