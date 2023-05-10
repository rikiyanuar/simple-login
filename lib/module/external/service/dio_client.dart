import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';

class DioClient {
  final Function()? logout;

  Dio get dio => _getDio();

  DioClient({this.logout});

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
    );
    Dio dio = Dio(options);
    dio.interceptors.addAll(<Interceptor>[
      DioLogInterceptor(),
      _loggingInterceptor(),
    ]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (RequestOptions options,
          RequestInterceptorHandler requestInterceptorHandler) async {
        try {
          return requestInterceptorHandler.next(options);
        } catch (e) {
          return requestInterceptorHandler.next(options);
        }
      },
      onResponse: (Response response,
          ResponseInterceptorHandler responseInterceptorHandler) {
        return responseInterceptorHandler.next(response);
      },
      onError: (DioError error,
          ErrorInterceptorHandler errorInterceptorHandler) async {
        _onErrorFunction(error, errorInterceptorHandler);
      },
    );
  }

  _onErrorFunction(
      DioError error, ErrorInterceptorHandler errorInterceptorHandler) {
    if (error.response?.statusCode == 401) {
      logout!();
    } else {
      return errorInterceptorHandler.next(error);
    }
  }
}
