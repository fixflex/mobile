part of 'make_task_open_cubit.dart';

@immutable
sealed class MakeTaskOpenState {}

final class MakeTaskOpenInitial extends MakeTaskOpenState {}
final class MakeTaskOpenLoading extends MakeTaskOpenState {}
final class MakeTaskOpenSuccess extends MakeTaskOpenState {}
final class MakeTaskOpenFailure extends MakeTaskOpenState {}
