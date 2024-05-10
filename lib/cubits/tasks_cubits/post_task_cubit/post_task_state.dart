part of 'post_task_cubit.dart';

@immutable
sealed class PostTaskState {}

final class PostTaskInitial extends PostTaskState {}
final class PostTaskLoading extends PostTaskState {}
final class PostTaskSuccess extends PostTaskState {
  PostTaskSuccess({required this.taskDetailsList});
  final List<TaskModel> taskDetailsList;
}
final class PostTaskFailure extends PostTaskState {}

