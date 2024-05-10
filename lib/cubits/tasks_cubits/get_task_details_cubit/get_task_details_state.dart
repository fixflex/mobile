part of 'get_task_details_cubit.dart';

@immutable
sealed class GetTaskDetailsState {
  get taskDetailsList => null;
}

final class GetTaskDetailsInitial extends GetTaskDetailsState {}
final class GetTaskDetailsLoading extends GetTaskDetailsState {}
final class GetTaskDetailsEmpty extends GetTaskDetailsState {}
final class GetTaskDetailsSuccess extends GetTaskDetailsState {
  GetTaskDetailsSuccess({required this.taskDetailsList});
  final List<TaskModel> taskDetailsList;
}
final class GetTaskDetailsFailure extends GetTaskDetailsState {}
