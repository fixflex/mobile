import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/models/tasker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'become_a_tasker_state.dart';

class BecomeATaskerCubit extends Cubit<BecomeATaskerState> {
  BecomeATaskerCubit() : super(BecomeATaskerInitial());

  static BecomeATaskerCubit get(context) => BlocProvider.of(context);
  var CategoryController = TextEditingController();
  bool isTaskDetailsScreenOpen = false;

  Future<void> becomeATasker(Position position) async {
    emit(BecomeATaskerLoading());
    try {
      var response = await DioApiHelper.postData(
        url: EndPoints.BecomeATasker(),
        data: {
          "categories": [CategoryController.text],
          "location": {
            "coordinates": [position.longitude, position.latitude]
          }
        },
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data['data'];
        final List<TaskerModel> taskerDateList = [];
        TaskerModel taskerModel = TaskerModel.fromJson(data);
        taskerDateList.add(taskerModel);
        emit(BecomeATaskerSuccess(taskerDateList: taskerDateList ));
      } else {
        emit(BecomeATaskerFailure());
      }
    } catch (e) {
      emit(BecomeATaskerFailure());
    }
  }

  void resetBecomeATaskerCubit() {
    CategoryController.clear();
    isTaskDetailsScreenOpen = false;
    emit(BecomeATaskerInitial());
  }
}
