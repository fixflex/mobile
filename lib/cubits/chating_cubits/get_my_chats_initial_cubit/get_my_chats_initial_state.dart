part of 'get_my_chats_initial_cubit.dart';

@immutable
sealed class GetMyChatsInitialState {}

final class GetMyChatsInitialInitial extends GetMyChatsInitialState {}
final class GetMyChatsInitialLoading extends GetMyChatsInitialState {}
final class GetMyChatsInitialSuccess extends GetMyChatsInitialState {
  GetMyChatsInitialSuccess({required this.myChatsDataModel});
  final List<MyChatsDataModel> myChatsDataModel;
}
final class GetMyChatsInitialNoChats extends GetMyChatsInitialState {}
final class GetMyChatsInitialFailure extends GetMyChatsInitialState {}
