import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../helper/secure_storage/secure_storage.dart';
import '../../screens/login_screen.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  static LogoutCubit get(context) => BlocProvider.of(context);

void logout(BuildContext context) async {
  Fluttertoast.showToast(
      msg: 'Logout Successfully',
      fontSize: 20,
      backgroundColor: Colors.green);
  SecureStorage.deleteData(key: SecureKey.token);
  SecureStorage.deleteData(key: SecureKey.userId)
      .then((value) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  });
  emit(LogoutSuccessState());
}
}
