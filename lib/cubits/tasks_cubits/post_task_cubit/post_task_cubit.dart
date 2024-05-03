import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'post_task_state.dart';

class PostTaskCubit extends Cubit<PostTaskState> {
  PostTaskCubit() : super(PostTaskInitial());

  static PostTaskCubit get(context) => BlocProvider.of(context);
  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  var budgetController = TextEditingController();
  var dueDateController = TextEditingController();
  var categoryIdController = TextEditingController();
  var cityController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();


  void postTask({
    required String title,
    required String details,
    required String budget,
    required String dueDate,
    required String categoryId,
    required String city,
    required String latitude,
    required String longitude,
    // required String userId,
  }) async {
    emit(PostTaskLoading());
    try {
      final response = await DioApiHelper.postData(
        url: EndPoints.tasks,
        // token: SecureVariables.token,
        data: {
          'title': title,
          'details': details,
          'budget': budget,
          'dueDate': dueDate,
          'categoryId': categoryId,
          'city': city,
          'latitude': latitude,
          'longitude': longitude,
          // 'userId': userId,
        },
      );
      if (response.statusCode == 200) {
        emit(PostTaskSuccess());
      } else {
        emit(PostTaskFailure());
      }
    } catch (e) {
      emit(PostTaskFailure());
    }
  }

  void changeCounterText() {
    String? counterText = titleController.text ;
        if(counterText.length <10 ){
          emit(CounterTextChange(counterText: 'Minimum 10 characters'));
          // return 'Minimum 10 characters';
        } else {
          emit(CounterMaxTextChange(counterText: 'Maximum 100 characters'));
          // return 'Maximum 100 characters';
        }
  }
}
