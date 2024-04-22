import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'obscure_password_state.dart';

class ObscurePasswordCubit extends Cubit<ObscurePasswordState> {
  ObscurePasswordCubit() : super(ObscurePasswordInitial());

  static ObscurePasswordCubit get(context) => BlocProvider.of(context);

  bool isPasswordShow = true;
  IconData passwordIcon = Icons.visibility;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    if (isPasswordShow) {
      passwordIcon = Icons.visibility;
      emit(ObscurePasswordVisibility());
    } else {
      passwordIcon = Icons.visibility_off;
      emit(ObscurePasswordVisibilityOff());
    }
  }
}
