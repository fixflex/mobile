part of 'get_user_data_cubit.dart';

@immutable
sealed class GetUserDataState {}

final class GetUserDataInitial extends GetUserDataState {}
final class GetUserDataEmpty extends GetUserDataState {}
final class GetUserDataSuccess extends GetUserDataState {
  GetUserDataSuccess({required this.userDataList});
  final List<UserDataModel> userDataList;
}
final class GetUserDataFailure extends GetUserDataState {}
