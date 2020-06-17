import 'package:dio/dio.dart';

class ComicClient {
  static BaseOptions _options = BaseOptions(
    baseUrl: 'http://144.202.5.152',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static Dio _dio = Dio(_options);

  ComicClient._internal() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }

  static final ComicClient instance = ComicClient._internal();

  Dio get dio => _dio;
}
