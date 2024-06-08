part of 'create_new_chat_cubit.dart';

@immutable
sealed class CreateNewChatState {}

final class CreateNewChatInitial extends CreateNewChatState {}
final class CreateNewChatLoading extends CreateNewChatState {}
final class CreateNewChatSuccess extends CreateNewChatState {
  CreateNewChatSuccess({required this.myChatsDataModel});
  final MyChatsDataModel myChatsDataModel;
}
final class CreateNewChatFailure extends CreateNewChatState {}
