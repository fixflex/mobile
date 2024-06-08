import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'cansel_task_state.dart';

class CanselTaskCubit extends Cubit<CanselTaskState> {
  CanselTaskCubit() : super(CanselTaskInitial());

  static CanselTaskCubit get(context) => BlocProvider.of(context);

  Future<void> canselTask(String taskId) async {
    try {
      emit(CanselTaskLoading());
      var response = await DioApiHelper.patchData(
        url: EndPoints.canselTask(taskId: taskId)
      );
      if(response.statusCode == 200) {
        emit(CanselTaskSuccess());
      } else {
        emit(CanselTaskFailure());
      }
    } catch (e) {
      emit(CanselTaskFailure());
    }
  }

  void resetCanselTaskCubit() {
    emit(CanselTaskInitial());
  }
}
