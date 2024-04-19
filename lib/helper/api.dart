import 'package:dio/dio.dart';

final Dio dio = Dio();

class Api{
  Future<dynamic> get({required String url}) async{
    Response response = await dio.get(url);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('error in get request with status code:${response.statusCode}');
    }
  }
}