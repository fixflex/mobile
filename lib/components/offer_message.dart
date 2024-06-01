import 'package:fix_flex/components/default_form_field.dart';
import 'package:fix_flex/components/phone_number_verification.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/make_offer_cubit/make_offer_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_phone_number_cubit/update_phone_number_cubit.dart';
import 'package:fix_flex/models/task_model.dart';
import 'package:fix_flex/screens/task_details_screen.dart';
import 'package:fix_flex/widgets/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubits/tasks_cubits/details_cubit/details_cubit.dart';
import '../cubits/users_cubits/verification/send_verification_code_cubit/send_verification_code_cubit.dart';
import '../screens/post_a_task_screen.dart';

class OfferMessage extends StatelessWidget {
  const OfferMessage({super.key});

  static const String id = 'OfferMessage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return[
              BlocBuilder<DetailsCubit,DetailsState>(
                builder: (context,state) {
                  return SliverAppBarWidget(
                      title:'Offer Message',
                      icon: Icons.arrow_back,
                      iconSize: 30,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      backgroundColor: DetailsCubit.get(context).detailsController.text.length < 25
                          ? Colors.grey
                          : kPrimaryColor,
                  );
                }
              )
            ];
          },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  DetailsBoxWidget(
                    title: 'Offer Message',
                    description: 'Enter your offer message',
                  ),
                ],
              ),
            ),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
        return BlocConsumer<MakeOfferCubit, MakeOfferState>(
            listener: (context, state) {
              if (state is MakeOfferSuccess) {
                Navigator.popUntil(
                    context, ModalRoute.withName(TaskDetailsScreen.id));
              } else if (state is VerifyPhoneNumber) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('You must verify your phone number'),
                    content: Text('send a verification code to your whatsapp'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      BlocConsumer<SendVerificationCodeCubit,
                          SendVerificationCodeState>(listener: (context, state) {
                        if (state is SendVerificationCodeSuccess) {
                          Navigator.pushReplacementNamed(
                              context, PhoneNumberVerification.id);
                        } else if (state is NoPhoneNumber) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                              Text('You must have a phone number to verify'),
                              content:  Form(
                                key: UpdatePhoneNumberCubit.get(context).PhoneNumberFormKey,
                                child: defaultFormField(
                                  width: 330,
                                  controller: UpdatePhoneNumberCubit.get(context).PhoneNumberController,
                                  keyType: TextInputType.phone,
                                  maxLength: 11,
                                  onChanged: (value) {
                                    if (value.length == 11) {
                                      FocusScope.of(context)
                                          .focusedChild!
                                          .unfocus();
                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  fillColor: Colors.white,
                                  validate: RegisterCubit.get(context).validatePhoneNumber,
                                  prefix: Icons.phone,
                                  label: 'Enter Your Phone Number',
                                ),
                              ),
                              actions: [
                                BlocConsumer<UpdatePhoneNumberCubit,UpdatePhoneNumberState>(
                                    listener: (context, state) async {
                                      if (state is UpdatePhoneNumberSuccess) {
                                        await SendVerificationCodeCubit.get(context)
                                            .sendVerificationCode();
                                        Navigator.pushReplacementNamed(context, PhoneNumberVerification.id);
                                      } else if (state is UpdatePhoneNumberFailure) {
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
                                    },
                                    builder: (context,state) {
                                      return TextButton(
                                        onPressed: () async {
                                          if(UpdatePhoneNumberCubit.get(context).PhoneNumberFormKey.currentState!.validate()) {
                                            await UpdatePhoneNumberCubit.get(context).updatePhoneNumber();
                                          }
                                        },
                                        child: Text('OK'),
                                      );
                                    }
                                ),
                              ],
                            ),
                          );
                        }
                      }, builder: (context, state) {
                        return TextButton(
                          onPressed: () async {
                            await SendVerificationCodeCubit.get(context)
                                .sendVerificationCode();
                          },
                          child: Text('Send'),
                        );
                      }),
                    ],
                  ),
                );
              } else if (state is MakeOfferFailure) {
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
            }, builder: (context, state) {
          return FloatingActionButtonInPostATask(
            backgroundColor:
            DetailsCubit.get(context).detailsController.text.length < 25
                ? Colors.grey
                : kPrimaryColor,
            text: 'Push The Offer',
            onPressed: () async {
              if (DetailsCubit.get(context).detailsController.text.length <
                  25) {
                return;
              } else {
                await MakeOfferCubit.get(context).makeOffer(
                    OfferDetails: OfferDetails(
                      taskId: GetTaskDetailsCubit.get(context)
                          .state
                          .taskDetailsList[0]
                          .id,
                      message: DetailsCubit.get(context).detailsController.text,
                      price: BudgetCubit.get(context).newBudget,
                    ));
              }
            },
          );
        });
      }),
    );
  }
}
