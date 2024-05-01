part of 'get_my_data_cubit.dart';

@immutable
sealed class GetMyDataState {}

final class GetMyDataInitial extends GetMyDataState {}
final class GetMyDataEmpty extends GetMyDataState {}
final class GetMyDataSuccess extends GetMyDataState {
  GetMyDataSuccess({required this.myDataList});
  final List<UserDataModel> myDataList;
}
final class GetMyDataFailure extends GetMyDataState {}
