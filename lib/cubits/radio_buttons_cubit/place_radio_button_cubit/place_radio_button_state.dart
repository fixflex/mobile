part of 'place_radio_button_cubit.dart';

@immutable
sealed class PlaceRadioButtonState {}

final class PlaceRadioButtonInitial extends PlaceRadioButtonState {}
final class InPersonSelected extends PlaceRadioButtonState {
  final int? selected;
  InPersonSelected({required this.selected});
}
final class OnlineSelected extends PlaceRadioButtonState {
  final int? selected;
  OnlineSelected({required this.selected});
}
