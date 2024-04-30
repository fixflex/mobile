part of 'get_tasks_by_user_id_cubit.dart';

@immutable
sealed class GetTasksByUserIdState {}

final class GetTasksByUserIdInitial extends GetTasksByUserIdState {}
final class GetTasksByUserIdLoading extends GetTasksByUserIdState {}
final class GetTasksByUserIdEmpty extends GetTasksByUserIdState {}
final class GetTasksByUserIdSuccess extends GetTasksByUserIdState {
  GetTasksByUserIdSuccess({required this.MyTasksList});
  final List<TaskModel> MyTasksList;
}
final class GetTasksByUserIdFailure extends GetTasksByUserIdState {}
