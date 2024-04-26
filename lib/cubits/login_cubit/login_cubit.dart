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
  var isLoading = false;

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
      print(e);
      emit(LoginErrorState(error: 'Login Failed Please Try Again Later'));
        }
  }
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value?.isEmpty ?? true) {
      return 'emai can\'t be empty';
    } else if (!regex.hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  }

