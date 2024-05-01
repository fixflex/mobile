import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/end_points/end_points.dart';
import '../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../helper/secure_storage/secure_storage.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var signUpEmail = TextEditingController();
  var signUpPassword = TextEditingController();
  var signUpConfirmPassword = TextEditingController();
  var signUpFirstName = TextEditingController();
  var signUpLastName = TextEditingController();
  var signUpPhoneNumber = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>();
  var isLoading = false;


  Future <void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    try {
      final response = await DioApiHelper.postData(
          url: EndPoints.register, data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phone': phoneNumber,
      });
      if (response.statusCode == 201) {
        SecureStorage.saveData(
            key: SecureKey.token, value: response.data["accessToken"]);
        SecureStorage.saveData(
            key: SecureKey.userId, value: response.data["data"]["_id"]);
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState(error: response.data['message']));
      }
    } on Exception catch (e) {
      emit(RegisterErrorState(error: e.toString()));
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
      return '• Email can\'t be empty';
    } else if (!regex.hasMatch(value!)) {
      return '• Please enter a valid email address';
    }
    return null;
  }
  String? validatePhoneNumber(String? value) {
    if (value!.isEmpty) {
      return '• Phone number can\'t be empty';
    } else if (value.startsWith('01') == false ||
        value.length != 11) {
      return '• Invalid Phone Number';
    }
    return null;
  }
  String? ValidatePassword(String? value) {
    if (value!.isEmpty) {
      return '• Password can\'t be empty';
    }else if (value.length <8) {
      return '• Password must be longer than 8 characters.\n';
    }else if (!value.contains(RegExp(r'[A-Z]'))) {
      return '• Uppercase letter is missing.\n';
    }else if (!value.contains(RegExp(r'[a-z]'))) {
      return '• Lowercase letter is missing.\n';
    }else if (!value.contains(RegExp(r'[0-9]'))) {
      return '• Digit is missing.\n';
    }else if (!value.contains(RegExp(r'[!@#%&*(),.?":{}|<>]'))) {
      return '• Special character is missing.\n';
    }
    // If there are no error messages, the password is valid
    return null;
  }
}