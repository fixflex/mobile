import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'button_clicked_state.dart';

class ButtonClickedCubit extends Cubit<ButtonClickedState> {
  ButtonClickedCubit() : super(ButtonInitial());

  static ButtonClickedCubit get(context) => BlocProvider.of(context);

  static const Color white = Colors.white;
  static const Color primaryColor = Color(0xff134161);

  bool clicked = false;
  Color boxColor = white;
  Color iconColor = primaryColor;

  void changeColor() {
    boxColor = clicked ? white : primaryColor;
    iconColor = clicked ? primaryColor : white;
    clicked = !clicked;

    emit(ButtonClicked());
  }
}