import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'title_state.dart';

class TitleCubit extends Cubit<TitleState> {
  TitleCubit() : super(TitleInitial());

  static TitleCubit get(context) => BlocProvider.of(context);
  var titleController = TextEditingController();


  void changeTitleText() {
    String? counterText = titleController.text ;
    if(counterText.length >= 10 ){
      emit(TitleMaxTextChange());
    }else{
      emit(TitleMinTextChange());
  }
  }
  void resetTitleCubit() {
    titleController.clear();
    emit(TitleInitial());
  }
}
