import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'post_task_state.dart';

class PostTaskCubit extends Cubit<PostTaskState> {
  PostTaskCubit() : super(PostTaskInitial());

  static PostTaskCubit get(context) => BlocProvider.of(context);
  static final List<TaskModel> taskDetailsList = [];

  Future<void> postTask({
    required TaskModel taskModel,
    required BuildContext context,
  }) async {
    emit(PostTaskLoading());
    try {
      final response = await DioApiHelper.postData(
        url: EndPoints.tasks,
        data: {
          "title": taskModel.title,
          "details": taskModel.details,
          "budget": taskModel.budget,
          "categoryId": taskModel.categoryId,
          "dueDate": taskModel.dueDate,
          "location": taskModel.location,
        },
      );
      if (response.statusCode == 201) {
        Map<String,dynamic> tasks = response.data['data'];
          TaskModel taskModel = TaskModel.fromJson(tasks);
          taskDetailsList.add(taskModel);
          if (UploadTaskPhotosCubit.get(context).imagesFiles.isNotEmpty) {
            await UploadTaskPhotosCubit.get(context).uploadTaskPictures();
          }
        emit(PostTaskSuccess(taskDetailsList: taskDetailsList));
      } else {
        emit(PostTaskFailure());
      }
    } catch (e) {
      emit(PostTaskFailure());
    }
  }

  void resetPostTaskCubit() {
    taskDetailsList.clear();
    emit(PostTaskInitial());
  }
}
