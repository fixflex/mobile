import 'package:dio/dio.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_key.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/helper/secure_storage/secure_storage.dart';


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

}
