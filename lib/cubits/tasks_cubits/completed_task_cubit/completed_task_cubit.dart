import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'completed_task_state.dart';

class CompletedTaskCubit extends Cubit<CompletedTaskState> {
  CompletedTaskCubit() : super(CompletedTaskInitial());

  static CompletedTaskCubit get(context) => BlocProvider.of(context);

  Future<void> CompletedTasks(String taskId) async {
    try {
      emit(CompletedTaskLoading());
      var response = await DioApiHelper.patchData(
        url: EndPoints.completedTask(taskId: taskId)
      );
      if(response.statusCode == 200) {
        emit(CompletedTaskSuccess());
      } else {
        emit(CompletedTaskFailure());
      }
    } catch (e) {
      emit(CompletedTaskFailure());
    }
  }

  void resetCompletedTaskCubit() {
    emit(CompletedTaskInitial());
  }
}
