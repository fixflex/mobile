import 'package:fix_flex/cubits/tasks_cubits/search_task_cubit/search_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helper/network/dio_api_helper.dart';
import '../../../models/task_model.dart';

class TaskCubit extends Cubit<SearchTaskState> {
  TaskCubit() : super(TaskInitial()) {}

  static TaskCubit get(context) => BlocProvider.of(context);
  final TextEditingController searchController = TextEditingController();

  Future<void> fetchData({required String query}) async {
    List<TaskModel> result = [];

    if (searchController.text.isEmpty) {
      return emit(TaskEmptyState());
    } else if (searchController.text.isNotEmpty) {
      emit(TaskLoadingState());
    }

    final response = await DioApiHelper.getData(
      url: "tasks?keyword=$query",
    );

    if (response.statusCode == 200) {
      result = [];
      List<dynamic> data = response.data["data"];
      for (var taskJson in data) {
        TaskModel task = TaskModel.fromJson(taskJson);
        result.add(task);
      }

      emit(TaskSuccessState(result));
    } else {
      emit(TaskFailureState('Failed to fetch data'));
    }
  }

  void resetSearchTaskCubit() {
    searchController.clear();
    emit(TaskInitial());
  }
}
