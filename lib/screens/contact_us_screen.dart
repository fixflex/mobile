import 'package:fix_flex/components/back_ground.dart';
import 'package:fix_flex/components/default_form_field.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/contact_us_cubit/contact_us_cubit.dart';
import 'package:fix_flex/cubits/contact_us_cubit/contact_us_state.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackGround(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: SingleChildScrollView(
                  child: BlocProvider(
                    create: (context) => ContactUsCubit(),
                    child: BlocConsumer<ContactUsCubit, ContactUsState>(
                      listener: (context, state) async {
                        if (state is ContactUsLoadingState) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ContactUsCubit.get(context).isLoading = true;
                        } else if (state is ContactUsErrorState) {
                          ContactUsCubit.get(context).isLoading = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 4),
                              content: Text(
                                state.error,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else if (state is ContactUsSuccessState) {
                          ContactUsCubit.get(context).isLoading = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        }
                      },
                      builder: (context, state) {
                        var cubit = ContactUsCubit.get(context);
                        return Form(
                          key: cubit.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Contact",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Us",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff92d3f3)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: Text(
                                  "Any question or remarks? Just write us a message!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(.8)),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),

                              //Email TFF
                              defaultFormField(
                                width: MediaQuery.of(context).size.width,
                                controller: cubit.emailController,
                                keyType: TextInputType.emailAddress,
                                validate: cubit.validateEmail,
                                fillColor: Colors.white,
                                prefix: Icons.email,
                                label: 'Email',
                              ),
                              const SizedBox(
                                height: 50,
                              ),

                              //Message TTF
                              defaultFormField(
                                  width: MediaQuery.of(context).size.width,
                                  controller: cubit.MessageController,
                                  keyType: TextInputType.text,
                                  validate: cubit.validateEmail,
                                  fillColor: Colors.white,
                                  prefix: Icons.message,
                                  label: 'Enter Message',
                                  maxLines: 2),
                              const SizedBox(
                                height: 100,
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * .8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: kPrimaryColor,
                                ),
                                child: AbsorbPointer(
                                  absorbing:
                                      ContactUsCubit.get(context).isLoading,
                                  child: TextButton(
                                    onPressed: () async {
                                      if (state is! ContactUsLoadingState &&
                                          state is! ContactUsSuccessState) {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          if (cubit.emailController.text
                                                  .isNotEmpty &&
                                              cubit.MessageController.text
                                                  .isNotEmpty) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                    child: ContactUsCubit.get(context).isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'Submit Message',
                                            style: TextStyle(
                                              // color: Color(0xff222a32),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
