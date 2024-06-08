part of 'rate_tasker_cubit.dart';

@immutable
sealed class RateTaskerState {}

final class RateTaskerInitial extends RateTaskerState {}
final class RateTaskerLoading extends RateTaskerState {}
final class AddNewRate extends RateTaskerState {}
final class RateTaskerSuccess extends RateTaskerState {}
final class AlreadyReviewed extends RateTaskerState {}
final class RateTaskerFailure extends RateTaskerState {}
