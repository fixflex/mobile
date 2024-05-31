import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import '../cubits/tasks_cubits/details_cubit/details_cubit.dart';
import '../cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import '../cubits/tasks_cubits/make_offer_cubit/make_offer_cubit.dart';
import '../cubits/users_cubits/update_phone_number_cubit/update_phone_number_cubit.dart';
import '../cubits/users_cubits/verification/send_verification_code_cubit/send_verification_code_cubit.dart';
import '../cubits/users_cubits/verification/verify_phone_number_cubit/verify_phone_number_cubit.dart';
import '../constants/constants.dart';
import '../models/task_model.dart';
import '../screens/task_details_screen.dart';
import '../widgets/otp_code_box_widget.dart';

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({Key? key}) : super(key: key);

  static const String id = 'PhoneNumberVerification';

  @override
  Widget build(BuildContext context) {
    final verifyPhoneNumberCubit = VerifyPhoneNumberCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('Verification Code',
                style: GoogleFonts.abel(
                    textStyle: TextStyle(
                      color: Color(0xff134161),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ))),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Text(
                'Enter the 6-digit code sent to your WhatsApp number',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  height: 52,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return OtpCodeBoxWidget(
                        index: index,
                        controller: verifyPhoneNumberCubit.codeControllers[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10);
                    },
                    itemCount: 6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<VerifyPhoneNumberCubit, VerifyPhoneNumberState>(
            builder: (context, state) {
              final label = verifyPhoneNumberCubit.canResendCode
                  ? 'Resend'
                  : 'Resend in ${verifyPhoneNumberCubit.resendCountdown}s';
              return Container(
                width: 160,
                child: FloatingActionButton.extended(
                  onPressed: verifyPhoneNumberCubit.canResendCode
                      ? () async {
                    verifyPhoneNumberCubit.startResendCooldown();
                    await SendVerificationCodeCubit.get(context)
                        .sendVerificationCode();
                  }
                      : null,
                  label: Text(label, style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.refresh, color: Colors.white),
                  backgroundColor: verifyPhoneNumberCubit.canResendCode ? kPrimaryColor : Colors.grey,
                ),
              );
            },
          ),
          BlocConsumer<VerifyPhoneNumberCubit, VerifyPhoneNumberState>(
            listener: (context, state) async {
              if (state is VerifyPhoneNumberSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                    return AlertDialog(
                      icon: Icon(
                          Icons.check_circle, color: Colors.green, size: 80),
                      alignment: Alignment.center,
                      content: Text('Phone Number Verified Successfully'),
                    );
                  },
                );
                await MakeOfferCubit.get(context).makeOffer(
                    OfferDetails: OfferDetails(
                      taskId: GetTaskDetailsCubit.get(context)
                          .state
                          .taskDetailsList[0]
                          .id,
                      message: DetailsCubit.get(context).detailsController.text,
                      price: BudgetCubit.get(context).newBudget,
                    ));
                if(MakeOfferCubit.get(context).state is MakeOfferSuccess){

                  Navigator.popUntil(
                      context, ModalRoute.withName(TaskDetailsScreen.id));
                  BudgetCubit.get(context).resetBudgetCubit();
                  DetailsCubit.get(context).resetDetailsCubit();
                  VerifyPhoneNumberCubit.get(context).resetVerifyPhoneNumberCubit();
                  UpdatePhoneNumberCubit.get(context).resetUpdatePhoneNumberCubit();
                }else if(MakeOfferCubit.get(context).state is MakeOfferFailure){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }

              }else if (state is VerifyPhoneNumberFailure){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('wrong verification code, please try again'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            builder: (context, state) {
              return Container(
                width: 160,
                child: FloatingActionButton.extended(
                  onPressed: verifyPhoneNumberCubit.isCodeComplete
                      ? () async {
                    await verifyPhoneNumberCubit.verifyPhoneNumber();
                  }
                      : null,
                  label: Text('Confirm', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.check, color: Colors.white),
                  backgroundColor: verifyPhoneNumberCubit.isCodeComplete ? kPrimaryColor : Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}