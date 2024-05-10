part of 'title_cubit.dart';

@immutable
sealed class TitleState {}

final class TitleInitial extends TitleState {}
final class TitleMinTextChange extends TitleState {}
final class TitleMaxTextChange extends TitleState {}
