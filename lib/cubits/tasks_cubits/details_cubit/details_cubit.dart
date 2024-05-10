import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(context) => BlocProvider.of(context);
  var detailsController = TextEditingController();

  void changeDetailsText() {
    String? counterText = detailsController.text ;
    if(counterText.length >= 25 ){
      emit(DetailsMaxTextChange());
    } else {
      emit(DetailsMinTextChange());
    }
  }
  void resetDetailsCubit() {
    detailsController.clear();
    emit(DetailsInitial());
  }

}
