import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import '../../../models/task_model.dart';

part 'get_tasks_by_user_id_state.dart';

class GetTasksByUserIdCubit extends Cubit<GetTasksByUserIdState> {
  GetTasksByUserIdCubit() : super(GetTasksByUserIdInitial());

  static GetTasksByUserIdCubit get(context) => BlocProvider.of(context);

  Future<void> getTasksByUserId(
      {required String? userId}) async {
    try {
      emit(GetTasksByUserIdLoading());
      var response = (await DioApiHelper.getData(
          url: EndPoints.tasks,
          query: {
            'userId': userId,
            'sort': '-createdAt',
            'limit': '100',
          }));
      if (response.statusCode == 200) {
        List<dynamic> tasks = response.data['data'];
        if (tasks.isEmpty) {
          emit(GetTasksByUserIdEmpty());
        } else {
          final List<TaskModel> MyTasksDataList = [];
          for (var task in tasks) {
            TaskModel taskModel = TaskModel.fromJson(task);
            MyTasksDataList.add(taskModel);
          }
          emit(GetTasksByUserIdSuccess(MyTasksList: MyTasksDataList));
        }
      } else {
        emit(GetTasksByUserIdFailure());
      }
    } catch (e) {
      emit(GetTasksByUserIdFailure());
    }
  }
  ResetGetTasksByUserIdState() {
    emit(GetTasksByUserIdInitial());
  }
}
