import 'package:fix_flex/cubits/login_cubit/login_cubit.dart';
import 'package:fix_flex/cubits/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../components/back_ground.dart';
import '../components/default_form_field.dart';
import '../cubits/login_cubit/login_state.dart';
import '../helper/secure_storage/secure_keys/secure_key.dart';
import '../helper/secure_storage/secure_keys/secure_variable.dart';
import '../helper/secure_storage/secure_storage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  static const String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            BackGround(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: BlocProvider(
                    create: (context) => LoginCubit(),
                    child: BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) async {
                        if (state is LoginLoadingState) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          LoginCubit.get(context).isLoading = true;
                        } else if (state is LoginErrorState) {
                          LoginCubit.get(context).isLoading = false;
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
                        } else if (state is LoginSuccessState) {
                          LoginCubit.get(context).isLoading = false;
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          Duration(milliseconds: 500);
                          SecureVariables.token =
                              await SecureStorage.getData(key: SecureKey.token);
                          SecureVariables.userId =
                              await SecureStorage.getData(key: SecureKey.userId);
                          await GetMyDataCubit.get(context).getMyData();
                          Navigator.pushReplacementNamed(context, HomeScreen.id);
                          LoginCubit.get(context).resetLoginCubit();
                          // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
                          OneSignal.initialize("6a3a9ea1-b670-44bb-83e9-599aa8ce1a58");
                          OneSignal.Notifications.requestPermission(true);
                          var userId = await SecureStorage.getData(key: SecureKey.userId);
                          OneSignal.login(userId.toString());
                        }
                      },
                      builder: (context, state) {
                        var cubit = LoginCubit.get(context);
                        return Form(
                          key: cubit.formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Image.asset(
                                'assets/images/fixFlex3.png',
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(
                                height: 100,
                              ),

                              //Email TFF
                              defaultFormField(
                                width: 330,
                                controller: cubit.emailController,
                                keyType: TextInputType.emailAddress,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9@a-zA-Z.]")),
                                ],
                                validate: cubit.validateEmail,
                                fillColor: Colors.white,
                                prefix: Icons.email,
                                label: 'Email',
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              //Password TFF
                              BlocBuilder<ObscurePasswordCubit,
                                  ObscurePasswordState>(
                                builder: (context, state) {
                                  return defaultFormField(
                                    width: 330,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: cubit.passwordController,
                                    keyType: TextInputType.visiblePassword,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return '• Password Can\'t be empty';
                                      }
                                      return null;
                                    },
                                    fillColor: Colors.white,
                                    prefix: Icons.lock,
                                    label: 'Password',
                                    suffix: ObscurePasswordCubit.get(context)
                                        .LoginPasswordIcon,
                                    suffixPressed: () {
                                      ObscurePasswordCubit.get(context)
                                          .changeLoginPasswordVisibility();
                                    },
                                    isPassword: ObscurePasswordCubit.get(context)
                                        .isLoginPasswordShow,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 130,
                              ),
                              //Login Button
                              Container(
                                width: 330,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xff134161),
                                  // color: Color(0xff222a32),
                                ),
                                child: AbsorbPointer(
                                  absorbing: LoginCubit.get(context).isLoading,
                                  child: TextButton(
                                    onPressed: () async{
                                      if (state is! LoginLoadingState &&
                                          state is! LoginSuccessState) {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          if (cubit.emailController.text
                                                  .isNotEmpty &&
                                              cubit.passwordController.text
                                                  .isNotEmpty) {
                                            await cubit.login(
                                              email: cubit.emailController.text
                                                  .toLowerCase(),
                                              password:
                                                  cubit.passwordController.text,
                                            );
                                            await CheckMyRoleCubit.get(context).checkMyRole();
                                            ObscurePasswordCubit.get(context).isLoginPasswordShow = true;
                                            ObscurePasswordCubit.get(context).isRegisterPasswordShow = true ;
                                            ObscurePasswordCubit.get(context).isRegisterConfirmPasswordShow = true;
                                          }
                                        }
                                      }
                                    },
                                    child: LoginCubit.get(context).isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'Login',
                                            style: TextStyle(
                                              // color: Color(0xff222a32),
                                              color: Colors.white,
                                            ),
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
                                    'Don\'t have an account ?',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (state is! LoginLoadingState &&
                                          state is! LoginSuccessState) {
                                        Navigator.pushNamed(
                                            context, RegisterScreen.id);
                                      }
                                    },
                                    child: const Text(
                                      'Register Now',
                                      style: TextStyle(
                                        color: Color(0xff66a3d5),
                                      ),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
