part of 'date_radio_button_cubit.dart';

@immutable
sealed class DateRadioButtonState {}

final class DateRadioButtonInitial extends DateRadioButtonState {}
final class OnDateRadioButtonsSelected extends DateRadioButtonState {
  final int? selected;
  final DateTime? onDateSelected;
  OnDateRadioButtonsSelected({required this.selected, required this.onDateSelected});
}
final class BeforeDateRadioButtonsSelected extends DateRadioButtonState {
  final int? selected;
  final DateTime? beforeDateSelected;
  BeforeDateRadioButtonsSelected({required this.selected, required this.beforeDateSelected});
}
final class FlexibleDateRadioButtonsSelected extends DateRadioButtonState {
  final int? selected;
  FlexibleDateRadioButtonsSelected({required this.selected});
}
