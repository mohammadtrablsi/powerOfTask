import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;


  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await _dio.get('$endPoint');
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    var response = await _dio.post('$endPoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat$data');
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat$endPoint');
    var response;
    try {
      var headers = {'Content-Type': 'application/json'};
      // Perform the PUT request
      response = await _dio.request(
        endPoint,
        data: data,
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
      );

      // Check the status code
      if (response.statusCode == 200) {
        print('Update successful: ${response.data}');
      } else {
        print('Failed to update. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // Handle error
      print('Error: ${e.response?.data ?? e.message}');
    }
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
  }) async {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat$endPoint');
    var response;
    try {
      var headers = {'Content-Type': 'application/json'};
      // Perform the PUT request
      response = await _dio.request(
        endPoint,
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      // Check the status code
      if (response.statusCode == 200) {
        print('deleted successful: ${response.data}');
      } else {
        print('Failed to delete. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // Handle error
      print('Error: ${e.response?.data ?? e.message}');
    }
    return response.data;
  }
}
