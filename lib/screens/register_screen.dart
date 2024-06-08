import 'package:fix_flex/components/back_ground.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'package:fix_flex/screens/update_profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../components/default_form_field.dart';
import '../constants/constants.dart';
import '../cubits/obscure_password_cubit/obscure_password_cubit.dart';
import '../cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import '../helper/secure_storage/secure_keys/secure_key.dart';
import '../helper/secure_storage/secure_keys/secure_variable.dart';
import '../helper/secure_storage/secure_storage.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({
    super.key,
  });

  static const String id = 'RegisterScreen';

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
              child: BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) async {
                  if (state is RegisterLoadingState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    RegisterCubit.get(context).isLoading = true;

                  }
                  else if (state is RegisterErrorState) {
                    RegisterCubit.get(context).isLoading = false;
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                        content: Text(
                          state.error,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  else if(state is PhoneNumberIsAlreadyExist){
                    RegisterCubit.get(context).isLoading = false;
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                        content: Text(
                          '• Phone number is already exist',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  else if(state is EmailIsAlreadyExist){
                    RegisterCubit.get(context).isLoading = false;
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                        content: Text(
                          '• Email is already exist',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  else if (state is RegisterSuccessState) {
                    RegisterCubit.get(context).isLoading = false;
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    SecureVariables.token =
                        await SecureStorage.getData(key: SecureKey.token);
                    SecureVariables.userId =
                        await SecureStorage.getData(key: SecureKey.userId);
                    GetMyDataCubit.get(context).getMyData();
                    Navigator.pushReplacementNamed(context, UpdateProfilePictureScreen.id);
                    RegisterCubit.get(context).resetRegisterCubit();
                    CheckMyRoleCubit.get(context).checkMyRole();
                    OneSignal.initialize("6a3a9ea1-b670-44bb-83e9-599aa8ce1a58");
                    OneSignal.Notifications.requestPermission(true);
                    var userId = await SecureStorage.getData(key: SecureKey.userId);
                    OneSignal.login(userId.toString());
                  }
                },
                builder: (context, state) {
                  var cubit = RegisterCubit.get(context);
                  return Form(
                    key: cubit.signUpFormKey,
                    child: SingleChildScrollView(
                      child: BlocProvider(
                        create: (context) => RegisterCubit(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),

                            //first name TFF
                            defaultFormField(
                              width: 330,
                              controller: cubit.signUpFirstName,
                              keyType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]')),
                              ],
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return '• First name can\'t be empty';
                                } else if (value.length < 3) {
                                  return '• First name must be at least 3 characters';
                                }
                                return null;
                              },
                              prefix: Icons.person,
                              label: 'First Name',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            //Last Name TFF
                            defaultFormField(
                              width: 330,
                              controller: cubit.signUpLastName,
                              keyType: TextInputType.name,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]')),
                              ],
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return '• Last name can\'t be empty';
                                } else if (value.length < 3) {
                                  return '• Last name must be at least 3 characters';
                                }
                                return null;
                              },
                              prefix: Icons.person,
                              label: 'Last Name',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            //Email TFF
                            defaultFormField(
                              width: 330,
                              controller: cubit.signUpEmail,
                              keyType: TextInputType.emailAddress,
                              validate: cubit.validateEmail,
                              prefix: Icons.email,
                              label: 'Email',
                              fillColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            // Phone Number TFF
                            defaultFormField(
                              width: 330,
                              controller: cubit.signUpPhoneNumber,
                              keyType: TextInputType.phone,
                              counterText: '',
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
                              validate: cubit.validatePhoneNumber,
                              prefix: Icons.phone,
                              label: 'Phone Number',
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            //Password TFF
                            BlocBuilder<ObscurePasswordCubit,
                                ObscurePasswordState>(
                              builder: (context, state) {
                                return defaultFormField(
                                  width: 330,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: cubit.signUpPassword,
                                  keyType: TextInputType.visiblePassword,
                                  validate: cubit.ValidatePassword,
                                  fillColor: Colors.white,
                                  prefix: Icons.lock,
                                  label: 'Password',
                                  suffix: ObscurePasswordCubit.get(context)
                                      .RegisterPasswordIcon,
                                  suffixPressed: () {
                                    ObscurePasswordCubit.get(context)
                                        .changeRegisterPasswordShowVisibility();
                                  },
                                  isPassword: ObscurePasswordCubit.get(context)
                                      .isRegisterPasswordShow,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            BlocBuilder<ObscurePasswordCubit,
                                ObscurePasswordState>(
                              builder: (context, state) {
                                //Confirm Password TFF
                                return defaultFormField(
                                  width: 330,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: cubit.signUpConfirmPassword,
                                  keyType: TextInputType.visiblePassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return '• Confirm password Can\'t be empty';
                                    } else if (value !=
                                        cubit.signUpPassword.text) {
                                      return '• Passwords do not match';
                                    }
                                    return null;
                                  },
                                  fillColor: Colors.white,
                                  prefix: Icons.lock,
                                  label: 'Confirm Password',
                                  suffix: ObscurePasswordCubit.get(context)
                                      .RegisterConfirmPasswordIcon,
                                  suffixPressed: () {
                                    ObscurePasswordCubit.get(context)
                                        .changeRegisterConfirmPasswordShowVisibility();
                                  },
                                  isPassword: ObscurePasswordCubit.get(context)
                                      .isRegisterConfirmPasswordShow,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 100,
                            ),

                            //Register Button

                            Container(
                              width: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: kPrimaryColor,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (state is ! RegisterLoadingState && state is ! RegisterSuccessState) {
                                    if (cubit.signUpFormKey.currentState!.validate()) {
                                      cubit.register(
                                        firstName: cubit.signUpFirstName.text,
                                        lastName: cubit.signUpLastName.text,
                                        email:
                                            cubit.signUpEmail.text.toLowerCase(),
                                        phoneNumber: cubit.signUpPhoneNumber.text,
                                        password: cubit.signUpPassword.text,
                                      );
                                      ObscurePasswordCubit.get(context).isLoginPasswordShow = true;
                                      ObscurePasswordCubit.get(context).isRegisterPasswordShow = true ;
                                      ObscurePasswordCubit.get(context).isRegisterConfirmPasswordShow = true;
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Please fill all fields'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: RegisterCubit.get(context).isLoading
                                  ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(
                                'Register',
                                style: TextStyle(
                                  // color: Color(0xff222a32),
                                  color: Colors.white,
                                ),
                              ),
                              ),
                            ),
                            //Register line
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'already have an account ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (state is! RegisterLoadingState && state is! RegisterSuccessState) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    'Login Now',
                                    style: TextStyle(
                                      color: Color(0xff66a3d5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
