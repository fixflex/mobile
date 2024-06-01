part of 'get_my_chats_cubit.dart';

@immutable
sealed class GetMyChatsState {}

final class GetMyChatsInitial extends GetMyChatsState {}
final class GetMyChatsLoading extends GetMyChatsState {}
final class NoChats extends GetMyChatsState {}
final class GetMyChatsSuccess extends GetMyChatsState {
  GetMyChatsSuccess({required this.chatsHolders, required this.myChatsDataModel});
  final List<UserDataModel> chatsHolders;
  final List<MyChatsDataModel> myChatsDataModel;
}
final class GetMyChatsFailure extends GetMyChatsState {}
