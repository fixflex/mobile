import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'place_radio_button_state.dart';

class PlaceRadioButtonCubit extends Cubit<PlaceRadioButtonState> {
  PlaceRadioButtonCubit() : super(PlaceRadioButtonInitial());

  static PlaceRadioButtonCubit get(context) => BlocProvider.of(context);
  int? selectedPlace ;

  void inPerson(int index) {
    selectedPlace = index;
    emit(InPersonSelected(selected: selectedPlace));
  }
  void online(int index) {
    selectedPlace = index;
    emit(OnlineSelected(selected: selectedPlace));
  }

  void resetPlaceRadioButtonCubit() {
    selectedPlace = 0;
    emit(PlaceRadioButtonInitial());
  }
}
