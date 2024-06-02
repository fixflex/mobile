part of 'get_chat_by_id_cubit.dart';

@immutable
sealed class GetChatByIdState {}

final class GetChatByIdInitial extends GetChatByIdState {}
final class GetChatByIdLoading extends GetChatByIdState {}
final class GetChatByIdSuccess extends GetChatByIdState {}
final class GetChatByIdFailure extends GetChatByIdState {}
