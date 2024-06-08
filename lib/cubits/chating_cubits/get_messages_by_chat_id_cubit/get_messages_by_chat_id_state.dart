part of 'get_messages_by_chat_id_cubit.dart';

@immutable
sealed class GetMessagesByChatIdState {}

final class GetMessagesByChatIdInitial extends GetMessagesByChatIdState {}
final class GetMessagesByChatIdLoading extends GetMessagesByChatIdState {}
final class GetMessagesByChatIdSuccess extends GetMessagesByChatIdState {
  GetMessagesByChatIdSuccess({required this.messagesList, required this.userId});
  final List<MessageModel> messagesList;
  final String userId;
}
final class GetMessagesByChatIdFailure extends GetMessagesByChatIdState {}
