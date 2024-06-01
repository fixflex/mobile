import '../../../models/task_model.dart';

abstract class SearchTaskState {}

class TaskInitial extends SearchTaskState {}

class TaskLoadingState extends SearchTaskState {}

class TaskEmptyState extends SearchTaskState {}

class TaskSuccessState extends SearchTaskState {
  final List<TaskModel> tasks;

  TaskSuccessState(this.tasks);
}

class TaskFailureState extends SearchTaskState {
  final String errorMessage;

  TaskFailureState(this.errorMessage);
}
