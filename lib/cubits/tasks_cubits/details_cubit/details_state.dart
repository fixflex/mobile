part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}
final class DetailsMinTextChange extends DetailsState {}
final class DetailsMaxTextChange extends DetailsState {}
