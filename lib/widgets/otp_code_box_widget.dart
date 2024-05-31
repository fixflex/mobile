import 'package:flutter/material.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/users_cubits/verification/verify_phone_number_cubit/verify_phone_number_cubit.dart';
import 'package:flutter/services.dart';

class OtpCodeBoxWidget extends StatelessWidget {
  const OtpCodeBoxWidget({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final int index;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final verifyPhoneNumberCubit = VerifyPhoneNumberCubit.get(context);

    return Form(
      child: Container(
        alignment: Alignment.center,
        width: 45,
        height: 48,
        child: TextFormField(
          controller: controller,
          maxLength: 1,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            if (value.length == 1 && index < 5) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).previousFocus();
            }
            verifyPhoneNumberCubit.codeControllers[index].text = value;
            verifyPhoneNumberCubit.checkCodeComplete();
          },
          style: TextStyle(fontSize: 22, color: kPrimaryColor),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 9),
            counterText: '',
            focusColor: kPrimaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
