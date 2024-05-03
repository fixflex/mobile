import 'package:dio/dio.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_key.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/helper/secure_storage/secure_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/end_points/end_points.dart';

class DioInterceptors extends Interceptor {

  static Dio dio = Dio();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
       await SecureStorage.getData(key: SecureKey.token);

    if (SecureVariables.token != null) {
      options.headers['authorization'] = 'Bearer ${SecureVariables.token}';
    }
    options.headers['accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.headers['lang'] = 'en';
       super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler)async {
    await SecureStorage.getData(key: SecureKey.token);
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response?.statusCode == 401) {
      if(SecureVariables.token != null){
        final response = await DioApiHelper.postData(url: EndPoints.refreshToken,);
        final jsonResponse = response.data;
        if (jsonResponse['success']) {
          await SecureStorage.saveData(key: SecureKey.token, value: jsonResponse['accessToken']);
          return handler.resolve(await retry(err.requestOptions));
        }

      }
    }
    super.onError(err, handler);
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

}
