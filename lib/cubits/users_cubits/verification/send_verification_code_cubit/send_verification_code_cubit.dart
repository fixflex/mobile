import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_verification_code_state.dart';

class SendVerificationCodeCubit extends Cubit<SendVerificationCodeState> {
  SendVerificationCodeCubit() : super(SendVerificationCodeInitial());

  static SendVerificationCodeCubit get(context) => BlocProvider.of(context);


  Future<void> sendVerificationCode() async {
    emit(SendVerificationCodeLoading());
    try {
      final response =
          await DioApiHelper.getData(url: EndPoints.sendVerificationCode);
      if (response.statusCode == 200) {
        emit(SendVerificationCodeSuccess());
      } else if(response.statusCode == 400 && response.data['message'] == 'You must have a phone number to verify') {
        emit(NoPhoneNumber());
      }
    } catch (e) {
      emit(SendVerificationCodeFailure());
    }
  }
}