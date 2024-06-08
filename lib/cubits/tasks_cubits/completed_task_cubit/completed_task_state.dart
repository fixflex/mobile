part of 'completed_task_cubit.dart';

@immutable
sealed class CompletedTaskState {}

final class CompletedTaskInitial extends CompletedTaskState {}
final class CompletedTaskLoading extends CompletedTaskState {}
final class CompletedTaskSuccess extends CompletedTaskState {}
final class CompletedTaskFailure extends CompletedTaskState {}
