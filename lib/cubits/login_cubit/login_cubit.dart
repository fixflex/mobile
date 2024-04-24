import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/end_points/end_points.dart';
import '../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../helper/secure_storage/secure_storage.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future login({required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final response = await DioApiHelper.postData(url: EndPoints.login, data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        // if( response.data["data"]["token"] == ){}
        SecureStorage.saveData(
            key: SecureKey.token, value: response.data["accessToken"]);
        emit(LoginSuccessState());
      }else if(response.statusCode == 400){
        emit(LoginErrorState(error: response.data['errors'][0]['msg']));
      }
      else {
        emit(LoginErrorState(error:response.data["message"]));
      }
    } on Exception catch (e) {
      emit(LoginErrorState(error: 'Login Failed Please Try Again Later'));
        }
  }
}
