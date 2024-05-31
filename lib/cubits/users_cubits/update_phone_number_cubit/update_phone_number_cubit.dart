import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'update_phone_number_state.dart';

class UpdatePhoneNumberCubit extends Cubit<UpdatePhoneNumberState> {
  UpdatePhoneNumberCubit() : super(UpdatePhoneNumberInitial());

  static UpdatePhoneNumberCubit get(context) => BlocProvider.of(context);
  var PhoneNumberController = TextEditingController();
  var PhoneNumberFormKey = GlobalKey<FormState>();

  Future<void> updatePhoneNumber() async {
    emit(UpdatePhoneNumberLoading());
    try {
      final response = await DioApiHelper.patchData(
        url: EndPoints.updateMyData,
        data: {
          'phoneNumber': PhoneNumberController.text,
        },
      );
      if (response.statusCode == 200) {
        emit(UpdatePhoneNumberSuccess());
      } else {
        emit(UpdatePhoneNumberFailure());
      }
    } catch (e) {
      emit(UpdatePhoneNumberFailure());
    }
  }
  void resetUpdatePhoneNumberCubit() {
    PhoneNumberController.clear();
    emit(UpdatePhoneNumberInitial());
  }
}

String? validatePhoneNumber(String? value) {
  if (value!.isEmpty) {
    return '• Phone number can\'t be empty';
  } else if (value.startsWith('01') == false || value.length != 11) {
    return '• Invalid Phone Number';
  }
  return null;
}
