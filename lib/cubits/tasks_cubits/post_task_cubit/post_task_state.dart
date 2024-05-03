part of 'post_task_cubit.dart';

@immutable
sealed class PostTaskState {}

final class PostTaskInitial extends PostTaskState {}
final class PostTaskLoading extends PostTaskState {}
final class PostTaskSuccess extends PostTaskState {}
final class PostTaskFailure extends PostTaskState {}
final class CounterTextChange extends PostTaskState {
  final String? counterText;
  CounterTextChange({required this.counterText});
}final class CounterMaxTextChange extends PostTaskState {
  final String? counterText;
  CounterMaxTextChange({required this.counterText});
}
