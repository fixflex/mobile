import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'make_task_open_state.dart';

class MakeTaskOpenCubit extends Cubit<MakeTaskOpenState> {
  MakeTaskOpenCubit() : super(MakeTaskOpenInitial());

  static MakeTaskOpenCubit get(context) => BlocProvider.of(context);

  Future<void> makeTaskOpen(String taskId) async {
    try {
      emit(MakeTaskOpenLoading());
      var response = await DioApiHelper.patchData(
        url: EndPoints.makeTaskOpen(taskId: taskId)
      );
      if(response.statusCode == 200) {
        emit(MakeTaskOpenSuccess());
      } else {
        emit(MakeTaskOpenFailure());
      }
    } catch (e) {
      emit(MakeTaskOpenFailure());
    }
  }
}
