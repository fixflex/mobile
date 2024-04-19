part of 'button_clicked_cubit.dart';

@immutable
sealed class ButtonClickedState {}

final class ButtonInitial extends ButtonClickedState {}
final class ButtonClicked extends ButtonClickedState {}
