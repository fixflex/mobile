import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'rate_tasker_state.dart';

class RateTaskerCubit extends Cubit<RateTaskerState> {
  RateTaskerCubit() : super(RateTaskerInitial());

  static RateTaskerCubit get(context) => BlocProvider.of(context);
  late double rate = 0.0;

  Future<void> rateTasker({required String taskId}) async {
    try {
      emit(RateTaskerLoading());
      var response = await DioApiHelper.postData(
        url: EndPoints.rateTasker(taskId: taskId),
        data: {
          'review': 'The task was done on time',
          'rating': rate,
        },
      );
      if (response.statusCode == 201) {
        emit(RateTaskerSuccess());
      } else if(response.statusCode == 400 && response.data['message'] == 'already_reviewed') {
        emit(AlreadyReviewed());
      }else {
        emit(RateTaskerFailure());
      }
    } catch (e) {
      emit(RateTaskerFailure());
    }
  }
  void setRate(double value){
    rate = value;
    emit(AddNewRate());
  }
  void resetRate(){
    rate = 0.0;
  }
}
