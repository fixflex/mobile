import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'obscure_password_state.dart';

class ObscurePasswordCubit extends Cubit<ObscurePasswordState> {
  ObscurePasswordCubit() : super(ObscurePasswordInitial());

  static ObscurePasswordCubit get(context) => BlocProvider.of(context);

  bool isLoginPasswordShow = true;
  IconData LoginPasswordIcon = Icons.visibility;

  bool isRegisterPasswordShow = true;
  IconData RegisterPasswordIcon = Icons.visibility;

  bool isRegisterConfirmPasswordShow = true;
  IconData RegisterConfirmPasswordIcon = Icons.visibility;

  void changeLoginPasswordVisibility() {
    isLoginPasswordShow = !isLoginPasswordShow;
    if (isLoginPasswordShow) {
      LoginPasswordIcon = Icons.visibility;
      emit(LoginObscurePasswordVisibility());
    } else {
      LoginPasswordIcon = Icons.visibility_off;
      emit(LoginObscurePasswordVisibilityOff());
    }
  }
  void changeRegisterPasswordShowVisibility() {
    isRegisterPasswordShow = !isRegisterPasswordShow;
    if (isRegisterPasswordShow) {
      RegisterPasswordIcon = Icons.visibility;
      emit(RegisterObscurePasswordVisibility());
    } else {
      RegisterPasswordIcon = Icons.visibility_off;
      emit(RegisterObscurePasswordVisibilityOff());
    }
  }
  void changeRegisterConfirmPasswordShowVisibility() {
    isRegisterConfirmPasswordShow = !isRegisterConfirmPasswordShow;
    if (isRegisterConfirmPasswordShow) {
      RegisterConfirmPasswordIcon = Icons.visibility;
      emit(RegisterObscureConfirmPasswordVisibility());
    } else {
      RegisterConfirmPasswordIcon = Icons.visibility_off;
      emit(RegisterObscureConfirmPasswordVisibilityOff());
    }
  }
}
