import 'package:dio/dio.dart';
import 'package:luvit/exceptions/api_exceptions.dart';

import '../app/app.logger.dart';

class ApiClient {
  final log = getLogger('ApiClient');
  final Dio dio = Dio(BaseOptions(baseUrl: ''));
  final Map<String, String>? headers;

  ApiClient({this.headers}) {
    dio.options.headers = headers;
    dio.options.headers.putIfAbsent("Content-Type", () => "application/json");
  }

  List<T> listRawDataToModel<T>(
    rawData, {
    String? key,
    String? additionalKey,
  }) {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    if (key == null) {
      data = rawData;
    } else {
      data = rawData[key];
      log.d('data with: $key, and value: $data');
      if (additionalKey != null) {
        data = rawData[key][additionalKey];
      }
    }
    List<T> results = [];
    for (var element in data) {
      results.add(assignType<T>(element));
    }
    return results;
  }

  Future<T> put<T>(
    String url,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final request = dio.put(
        url,
        options: Options(headers: headers, validateStatus: (status) => true),
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(request);
    } catch (e) {
      log.e('Unable to update: $e');
      rethrow;
    }
  }

  /// Assigns type based on a given Type[T]
  assignType<T>(var data) {
    switch (T) {
      // case UserModel:
      //   return data = UserModel.fromJson(data);
      case String:
        return data['message'];
      case List:
        return data;

      default:
    }
  }

  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? key,
    Options? options,
  }) async {
    log.i('url:$url');
    final request = dio.get(url,
        options: options ??
            Options(headers: headers, validateStatus: (status) => true),
        queryParameters: {
          if (queryParameters != null) ...queryParameters,
        });

    return _handleResponse<T>(request, key: key);
  }

  Future<List<T>> getList<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? key,
    String? additionalKey,
  }) async {
    log.i('url:$url, key:$key, queryParameters:$queryParameters');
    final request = dio.get(url,
        options: Options(headers: headers, validateStatus: (status) => true),
        queryParameters: {
          if (queryParameters != null) ...queryParameters,
        });

    return _handleListResponse<T>(request,
        key: key, additionalKey: additionalKey);
  }

  Future<T> post<T>(
    String url,
    dynamic data, {
    Map<String, dynamic> header = const {},
    Map<String, dynamic>? queryParameters,
    String? key,
  }) async {
    log.i('url:$url, data:$data');
    final request = dio.post(
      url,
      options: Options(headers: header, validateStatus: (status) => true),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse<T>(request, key: key);
  }

  Future<T> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    log.i('url:$url');
    try {
      final response = dio.delete(
        url,
        options: Options(headers: headers, validateStatus: (status) => true),
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response);
    } catch (e) {
      log.e('Unable to delete: $e');
      rethrow;
    }
  }

  Future<List<T>> _handleListResponse<T>(
    Future<Response> request, {
    String? key,
    String? additionalKey,
  }) async {
    try {
      final response = await request;
      log.v('statusCode:${response.statusCode}');
      log.v('response:${response.data}');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = response.data;

        return listRawDataToModel<T>(data,
            key: key, additionalKey: additionalKey);
      } else {
        throw ApiErrorHandler.handleError(response);
      }
    } catch (e) {
      log.e('Something went wrong: $e');
      rethrow;
    }
  }

  Future<T> _handleResponse<T>(
    Future<Response> request, {
    String? key,
  }) async {
    try {
      final response = await request;
      log.v('statusCode:${response.statusCode}');
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        var data = response.data;
        log.v('statusCode:${response.statusMessage}');
        log.v('raw:$data');
        if (key != null) data = data[key];
        log.v('data:$data');

        return assignType<T>(data);
      } else {
        throw ApiErrorHandler.handleError(response.data);
      }
    } catch (e) {
      log.e('Something went wrong: $e');
      rethrow;
    }
  }
}
