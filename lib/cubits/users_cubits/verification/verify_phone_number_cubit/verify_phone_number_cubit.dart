import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/constants/end_points/end_points.dart';

part 'verify_phone_number_state.dart';

class VerifyPhoneNumberCubit extends Cubit<VerifyPhoneNumberState> {
  VerifyPhoneNumberCubit() : super(VerifyPhoneNumberInitial()) {
    _initializeControllers();
  }

  static VerifyPhoneNumberCubit get(context) => BlocProvider.of(context);

  var verificationCodeController = TextEditingController();
  final List<TextEditingController> codeControllers = List.generate(6, (_) => TextEditingController());
  bool isCodeComplete = false;
  bool canResendCode = true;
  int resendCountdown = 30;
  Timer? resendTimer;

  void _initializeControllers() {
    for (var controller in codeControllers) {
      controller.addListener(checkCodeComplete);
    }
  }

  void checkCodeComplete() {
    isCodeComplete = codeControllers.every((controller) => controller.text.length == 1);
    print("Code Complete: $isCodeComplete");
    emit(VerifyPhoneNumberCodeUpdated());
  }

  Future<void> verifyPhoneNumber() async {
    emit(VerifyPhoneNumberLoading());
    try {
      final verificationCode = codeControllers.map((c) => c.text).join();
      verificationCodeController.text = verificationCode;
      print("Verification Code: $verificationCode");

      final response = await DioApiHelper.postData(
        url: EndPoints.verifyPhoneNumber,
        data: {"verificationCode": verificationCodeController.text},
      );
      if (response.statusCode == 200) {
        emit(VerifyPhoneNumberSuccess());
      } else {
        emit(VerifyPhoneNumberFailure());
      }
    } catch (e) {
      emit(VerifyPhoneNumberFailure());
    }
  }

  void startResendCooldown() {
    canResendCode = false;
    resendCountdown = 30;
    resendTimer?.cancel();
    emit(VerifyPhoneNumberResendCooldown());

    resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown > 0) {
        resendCountdown--;
        emit(VerifyPhoneNumberResendCountdown(resendCountdown));
      } else {
        canResendCode = true;
        resendTimer?.cancel();
        emit(VerifyPhoneNumberResendCooldownEnded());
      }
    });
  }

  @override
  Future<void> close() {
    resendTimer?.cancel();
    return super.close();
  }

  void resetVerifyPhoneNumberCubit() {
    for (var controller in codeControllers) {
      controller.clear();
    }
    verificationCodeController.clear();
    isCodeComplete = false;
    canResendCode = true;
    resendCountdown = 30;
    resendTimer?.cancel();
    emit(VerifyPhoneNumberInitial());
  }
}
