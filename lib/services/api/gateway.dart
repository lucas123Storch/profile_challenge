import 'package:dio/dio.dart';
import 'package:profile_challenge/services/api/dio_interceptor.dart';

abstract class Gateway {
  Gateway({required this.httpClient}) {
    httpClient.options = options;
    httpClient.interceptors.add(DioInterceptor());
  }

  final BaseOptions options = BaseOptions(
    receiveTimeout: 60000,
    connectTimeout: 60000,
  );

  final Dio httpClient;

  Future<T> request<T>(
    String url,
    T Function(dynamic) fromJson, {
    data = const {},
    String? token,
    HTTPMethod method = HTTPMethod.get,
  }) async {
    try {
      final options = Options(
        headers: token != null
            ? {
                'Authorization': 'Bearer $token',
              }
            : {
              'Content-type': 'appication/json',
              'Accept': 'appication/json'
            },
      );
      Response response;
      switch (method) {
        case HTTPMethod.get:
          response = await _get(url, options);
          break;
        case HTTPMethod.post:
          response = await _post(url, data, options);
          break;
        case HTTPMethod.put:
          response = await _put(url, data, options);
          break;
        case HTTPMethod.delete:
          response = await _delete(url, data, options);
          break;
      }

      if (response.statusCode == 200) {
        return fromJson(response.data != null ? response.data : "success");
      } else {
        return Future.error(DioErrorType.other);
      }
    } catch (e) {
      return Future.error(_handleError(e));
    }
  }

  Future<Response> _get(String url, Options options) async {
    try {
      final Response response = await httpClient.get(
        url,
        options: options,
      );
      return response;
    } catch (error) {
      return Future.error(_handleError(error));
    }
  }

  Future<Response> _post(String url, data, Options options) async {
    try {
      final Response response = await httpClient.post(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (error) {
      return Future.error(_handleError(error));
    }
  }

  Future<Response> _put(
    String url,
    data,
    Options options,
  ) async {
    try {
      final Response response = await httpClient.put(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (error) {
      return Future.error(_handleError(error));
    }
  }

  Future<Response> _delete(String url, data, Options options) async {
    try {
      final Response response = await httpClient.delete(
        url,
        data: data,
        options: options,
      );
      return response;
    } catch (error) {
      return Future.error(_handleError(error));
    }
  }

  String _handleError(error) {
    String errorDescription = "";
    if (error is DioError) {
      final DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${dioError.response?.statusCode} ${dioError.requestOptions.uri} ${dioError.requestOptions.method}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription =
          "Verifique suas credenciais ou entre em contato com o suporte.";
    }
    return errorDescription;
  }
}

enum HTTPMethod { get, post, delete, put }
