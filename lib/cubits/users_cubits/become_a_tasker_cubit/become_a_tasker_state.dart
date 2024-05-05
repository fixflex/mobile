part of 'become_a_tasker_cubit.dart';

@immutable
sealed class BecomeATaskerState {}

final class BecomeATaskerInitial extends BecomeATaskerState {}
final class BecomeATaskerLoading extends BecomeATaskerState {}
final class BecomeATaskerSuccess extends BecomeATaskerState {}
final class BecomeATaskerFailure extends BecomeATaskerState {}
