part of 'get_messages_by_chat_id_cubit.dart';

@immutable
sealed class GetMessagesByChatIdState {}

final class GetMessagesByChatIdInitial extends GetMessagesByChatIdState {}
final class GetMessagesByChatIdLoading extends GetMessagesByChatIdState {}
final class NoMessages extends GetMessagesByChatIdState {}
final class GetMessagesByChatIdSuccess extends GetMessagesByChatIdState {
  GetMessagesByChatIdSuccess({required this.messagesList});
  final List<MessageModel> messagesList;
}
final class GetMessagesByChatIdFailure extends GetMessagesByChatIdState {}
