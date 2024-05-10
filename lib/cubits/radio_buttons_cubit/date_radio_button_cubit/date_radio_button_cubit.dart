import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'date_radio_button_state.dart';

class DateRadioButtonCubit extends Cubit<DateRadioButtonState> {
  DateRadioButtonCubit() : super(DateRadioButtonInitial());

  static DateRadioButtonCubit get(context) => BlocProvider.of(context);

  DateRangePickerController onDatePickerController = DateRangePickerController();
  DateRangePickerController beforeDatePickerController = DateRangePickerController();
  DateTime? onDateSelected;
  DateTime? beforeDateSelected;
  int? selectedDate;

  void OnDateSelected({int? index,DateTime? date}) {
    selectedDate = index;
    onDateSelected = date;
    emit(OnDateRadioButtonsSelected(selected: selectedDate, onDateSelected: onDateSelected));
  }
  void BeforeDateSelected({int? index, DateTime? date}) {
    selectedDate = index;
    beforeDateSelected = date;
    emit(BeforeDateRadioButtonsSelected(selected: selectedDate, beforeDateSelected: beforeDateSelected));
  }
  void FlexibleDateSelected({required int index}) {
    selectedDate = index;
    emit(FlexibleDateRadioButtonsSelected(selected: selectedDate));
  }


  void resetDateRadioButtonCubit() {
    selectedDate = 0;
    onDateSelected = null;
    beforeDateSelected = null;
    onDatePickerController.selectedDate = null;
    beforeDatePickerController.selectedDate = null;
    emit(DateRadioButtonInitial());
  }
}