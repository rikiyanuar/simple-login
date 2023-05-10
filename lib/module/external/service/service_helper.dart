import 'package:dio/dio.dart';

import 'service_exception.dart';

abstract class ServiceHelper {
  Future<Response> get(String url, {dynamic data, Options options});

  Future<Response> post(String url, {dynamic data, Options options});

  Future<Response> put(String url, {dynamic data, Options options});

  Future<Response> delete(String url, {dynamic data, Options options});

  Future<Response> patch(String url, {dynamic data, Options options});
}

class ServiceHelperImpl extends ServiceHelper {
  final Dio dio;

  ServiceHelperImpl({required this.dio});

  @override
  Future<Response> get(url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;
    try {
      responseJson = await dio.get(
        url,
        options: options,
      );
    } on DioError catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> post(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;
    try {
      responseJson = await dio.post(
        url,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> put(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;

    try {
      responseJson = await dio.put(
        url,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> delete(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;

    try {
      responseJson = await dio.delete(
        url,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  @override
  Future<Response> patch(String url, {dynamic data, Options? options}) async {
    // ignore: avoid-late-keyword
    late Response responseJson;

    try {
      responseJson = await dio.patch(
        url,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      _errorCheck(e);
    }

    return responseJson;
  }

  _errorCheck(DioError e) {
    String? errorMessage;
    String? errorCode;
    dynamic errorResponse;

    if (e.response != null && e.response!.statusCode != null) {
      errorResponse = e.response!.data;

      if (e.response!.data != null && e.response!.data['message'] != null) {
        errorMessage = e.response!.data['message'];
      } else if (e.response!.data != null &&
          e.response!.data['Message'] != null) {
        errorMessage = e.response!.data['Message'];
      } else if (e.message.isNotEmpty) {
        errorMessage = e.message;
      }

      if (e.response!.data != null && e.response!.data["code"] != null) {
        errorCode = e.response!.data["code"].toString();
      } else if (e.response!.data != null && e.response!.data["Code"] != null) {
        errorCode = e.response!.data["Code"].toString();
      }

      if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 499) {
        throw ClientErrorException(
          errorMessage,
          errorCode,
          errorResponse,
          e,
        );
      } else {
        throw ServerErrorException(
          errorMessage,
          errorCode,
          errorResponse,
          e,
        );
      }
    } else {
      throw DioException(errorMessage, errorCode, errorResponse, e);
    }
  }
}
