part of 'get_tasker_by_id_cubit.dart';

@immutable
sealed class GetTaskerByIdState {}

final class GetTaskerByIdInitial extends GetTaskerByIdState {}
final class GetTaskerByIdLoading extends GetTaskerByIdState {}
final class GetTaskerByIdSuccess extends GetTaskerByIdState {
  final TaskerByIdModel tasker;
  GetTaskerByIdSuccess({required this.tasker});
}
final class GetTaskerByIdFailure extends GetTaskerByIdState {}
