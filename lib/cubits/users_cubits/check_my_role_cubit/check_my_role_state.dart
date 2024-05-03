part of 'check_my_role_cubit.dart';

@immutable
sealed class CheckMyRoleState {}

final class CheckMyRoleInitial extends CheckMyRoleState {}
final class CheckMyRoleLoading extends CheckMyRoleState {}
final class IamATasker extends CheckMyRoleState {
  IamATasker({required this.TaskerDataList});
  final List<TaskerModel> TaskerDataList;
}
final class IamAUser extends CheckMyRoleState {}
final class CheckMyRoleFailure extends CheckMyRoleState {}
