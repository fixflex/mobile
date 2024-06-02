part of 'post_message_cubit.dart';

@immutable
sealed class PostMessageState {}

final class PostMessageInitial extends PostMessageState {}
final class PostMessageLoading extends PostMessageState {}
final class PostMessageSuccess extends PostMessageState {}
final class PostMessageFailure extends PostMessageState {}