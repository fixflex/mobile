import 'package:fix_flex/models/tasker_by_id_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import '../../../models/tasker_model.dart';

part 'get_tasker_by_id_state.dart';

class GetTaskerByIdCubit extends Cubit<GetTaskerByIdState> {
  GetTaskerByIdCubit() : super(GetTaskerByIdInitial());

  static GetTaskerByIdCubit get(context) => BlocProvider.of(context);

  Future<void> getTaskerById({
    required String taskerId,
  }) async {
    emit(GetTaskerByIdLoading());
    try {
      final response = await DioApiHelper.getData(
        url: EndPoints.getTaskerById(taskerId: taskerId),
      );
      if (response.statusCode == 200) {
        // Map<String, dynamic> taskerData = response.data['data'];
        TaskerByIdModel taskerModel = TaskerByIdModel.fromJson(response.data['data']);
        emit(GetTaskerByIdSuccess(tasker: taskerModel));
      } else {
        emit(GetTaskerByIdFailure());
      }
    } catch (e) {
      emit(GetTaskerByIdFailure());
    }
  }
}
