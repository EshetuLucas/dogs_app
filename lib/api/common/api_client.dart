import 'package:dio/dio.dart';
import 'package:dogs_app/data_model/breed/breeds.dart';
import 'package:dogs_app/data_model/dogs/dogs.dart';
import 'package:dogs_app/exceptions/api_exceptions.dart';

import '../../app/app.logger.dart';

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
    String endPoint,
    dynamic data, {
    String? modelKey,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final request = dio.put(
        endPoint,
        options: Options(headers: headers, validateStatus: (status) => true),
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(request, modelKey: modelKey);
    } catch (e) {
      log.e('Unable to update: $e');
      rethrow;
    }
  }

  /// Assigns type based on a given Type[T]
  assignType<T>(var data) {
    switch (T) {
      case Dogs:
        return data = Dogs.fromJson(data);
      case Breeds:
        return data = Breeds.fromJson(data);

      default:
    }
  }

  Future<T> get<T>(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    String? key,
    String? modelKey,
    Options? options,
  }) async {
    log.i('endPoint:$endPoint');
    final request = dio.get(endPoint,
        options: options ??
            Options(headers: headers, validateStatus: (status) => true),
        queryParameters: {
          if (queryParameters != null) ...queryParameters,
        });

    return _handleResponse<T>(request, key: key, modelKey: modelKey);
  }

  Future<List<T>> getList<T>(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    String? key,
    String? additionalKey,
  }) async {
    log.i('endPoint:$endPoint, key:$key, queryParameters:$queryParameters');
    final request = dio.get(endPoint,
        options: Options(headers: headers, validateStatus: (status) => true),
        queryParameters: {
          if (queryParameters != null) ...queryParameters,
        });

    return _handleListResponse<T>(request,
        key: key, additionalKey: additionalKey);
  }

  Future<T> post<T>(
    String endPoint,
    dynamic data, {
    Map<String, dynamic> header = const {},
    Map<String, dynamic>? queryParameters,
    String? key,
    String? modelKey,
  }) async {
    log.i('endPoint:$endPoint, data:$data');
    final request = dio.post(
      endPoint,
      options: Options(headers: header, validateStatus: (status) => true),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse<T>(request, key: key, modelKey: modelKey);
  }

  Future<T> delete<T>(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    log.i('endPoint:$endPoint');
    try {
      final response = dio.delete(
        endPoint,
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
    String? modelKey,
  }) async {
    try {
      final response = await request;
      log.v('statusCode:${response.statusCode}');
      var data = response.data;
      log.v('statusCode:${response.statusMessage}');
      log.v('raw:$data');
      if (key != null) data = data[key];
      if (modelKey != null) data = {modelKey: data};
      log.v('data:$data');
      return assignType<T>(data);
    } on DioError catch (e) {
      throw ApiErrorHandler.handleError(e);
    } catch (e) {
      log.e('Something went wrong: $e');
      rethrow;
    }
  }
}
