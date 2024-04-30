import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import '../../../models/task_model.dart';

part 'get_task_details_state.dart';

class GetTaskDetailsCubit extends Cubit<GetTaskDetailsState> {
  GetTaskDetailsCubit() : super(GetTaskDetailsInitial());

  static GetTaskDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> getTaskDetails(
      {required String taskId}) async {
    try {
      emit(GetTaskDetailsLoading());
      var response = (await DioApiHelper.getData(
          url: EndPoints.getTask(id: taskId),
          query: {
            'sort': '-createdAt',
            'limit': '100',
          }));
      if (response.statusCode == 200) {
        Map<String,dynamic> tasks = response.data['data'];
        if (tasks.isEmpty) {
          emit(GetTaskDetailsEmpty());
        } else {
          final List<TaskModel> taskDetailsList = [];
            TaskModel taskModel = TaskModel.fromJson(tasks);
            taskDetailsList.add(taskModel);
          emit(GetTaskDetailsSuccess(taskDetailsList: taskDetailsList));
        }
      } else {
        emit(GetTaskDetailsFailure());
      }
    } catch (e) {
      emit(GetTaskDetailsFailure());
    }
  }
}
