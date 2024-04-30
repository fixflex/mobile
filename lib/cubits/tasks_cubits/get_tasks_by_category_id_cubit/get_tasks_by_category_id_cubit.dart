import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import '../../../models/task_model.dart';

part 'get_tasks_by_category_id_state.dart';

class GetTasksByCategoryIdCubit extends Cubit<GetTasksByCategoryIdState> {
  GetTasksByCategoryIdCubit() : super(GetTasksByCategoryIdInitial());

  static GetTasksByCategoryIdCubit get(context) => BlocProvider.of(context);

  Future<void> getTasksByCategoryId(
      {required String categoryId}) async {
    try {
      emit(GetTasksByCategoryIdLoading());
      var response = (await DioApiHelper.getData(
          url: EndPoints.tasks,
          query: {
            'categoryId': categoryId,
            'sort': '-createdAt',
            'limit': '100',
            'status': 'OPEN',
          }));
      if (response.statusCode == 200) {
        List<dynamic> tasks = response.data['data'];
        if (tasks.isEmpty) {
          emit(GetTasksByCategoryIdEmpty());
        } else {
          final List<TaskModel> tasksDataList = [];
          for (var task in tasks) {
            TaskModel taskModel = TaskModel.fromJson(task);
            tasksDataList.add(taskModel);
          }
          emit(GetTasksByCategoryIdSuccess(tasksDataList: tasksDataList));
        }
      } else {
        emit(GetTasksByCategoryIdFailure());
      }
    } catch (e) {
      emit(GetTasksByCategoryIdFailure());
    }
  }
}

