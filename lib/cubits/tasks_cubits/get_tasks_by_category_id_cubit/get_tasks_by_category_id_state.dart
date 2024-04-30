part of 'get_tasks_by_category_id_cubit.dart';

@immutable
sealed class GetTasksByCategoryIdState {}

final class GetTasksByCategoryIdInitial extends GetTasksByCategoryIdState {}
final class GetTasksByCategoryIdLoading extends GetTasksByCategoryIdState {}
final class GetTasksByCategoryIdEmpty extends GetTasksByCategoryIdState {}
final class GetTasksByCategoryIdSuccess extends GetTasksByCategoryIdState {
  GetTasksByCategoryIdSuccess({required this.tasksDataList});
  final List<TaskModel> tasksDataList;
}
final class GetTasksByCategoryIdFailure extends GetTasksByCategoryIdState {}
