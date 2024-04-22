import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constants/end_points/end_points.dart';

class DioApiHelper {

  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'bearer $token',
        "Accept": "application/json"
      };
      return await dio.post(url,
          queryParameters: query,
          data: data,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }


    static Future<Response> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'bearer $token',
      };
      Response response = await dio.put(
        url,
        data: data,
        queryParameters: query,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }


  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'bearer $token',
        "Accept": "application/json"
      };
      return await dio.get(url,
          queryParameters: query,
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }


  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
      };
      return await dio.delete(url, queryParameters: query, data: data);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}




// import 'package:dio/dio.dart';
//
// final Dio dio = Dio();
//
// class Api{
//   Future<dynamic> get({required String url}) async{
//     Response response = await dio.get(url);
//     if(response.statusCode == 200){
//       return response.data;
//     }else{
//       throw Exception('error in get request with status code:${response.statusCode}');
//     }
//   }
// }



