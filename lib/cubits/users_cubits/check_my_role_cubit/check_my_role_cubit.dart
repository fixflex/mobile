import 'package:fix_flex/models/tasker_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'check_my_role_state.dart';

class CheckMyRoleCubit extends Cubit<CheckMyRoleState> {
  CheckMyRoleCubit() : super(CheckMyRoleInitial());

  static CheckMyRoleCubit get(context) => BlocProvider.of(context);

   checkMyRole() async {
    emit(CheckMyRoleLoading());
    try {
      final response = await DioApiHelper.getData(
        url: EndPoints.checkMyRole(),
      );
      if (response.statusCode == 200) {
          Map<String, dynamic> taskerData = response.data['data'];
          List<TaskerModel> TaskerDataList= [];
          TaskerModel taskerModel = TaskerModel.fromJson(taskerData);
          TaskerDataList.add(taskerModel);
          emit(IamATasker(TaskerDataList: TaskerDataList));

        } else if(response.statusCode == 404) {
        emit(IamAUser());
        } else {
        emit(CheckMyRoleFailure());
      }
    } catch (e) {
      emit(CheckMyRoleFailure());
    }
  }

  void resetCheckMyRoleCubit(){
   emit(CheckMyRoleInitial());
  }

}
