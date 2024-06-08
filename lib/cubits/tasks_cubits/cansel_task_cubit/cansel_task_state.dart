part of 'cansel_task_cubit.dart';

@immutable
sealed class CanselTaskState {}

final class CanselTaskInitial extends CanselTaskState {}
final class CanselTaskLoading extends CanselTaskState {}
final class CanselTaskSuccess extends CanselTaskState {}
final class CanselTaskFailure extends CanselTaskState {}
