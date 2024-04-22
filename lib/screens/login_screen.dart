import 'package:fix_flex/cubits/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:fix_flex/models/custom_clippers.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/default_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static var emailController = TextEditingController();

  static var passwordController = TextEditingController();

  static var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ClipPath(
            clipper: FirstClipper(),
            child: Container(
              color: const Color(0xffd7e0e6),
            ),
          ),
          ClipPath(
            clipper: SecondClipper(),
            child: Container(
              color: const Color(0xff92d3f3),
            ),
          ),
          ClipPath(
            clipper: ThirdClipper(),
            child: Container(
              color: const Color(0xff306686),
            ),
          ),
          ClipPath(
            clipper: FourthClipper(),
            child: Container(
              color: const Color(0xff134161),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                        controller: emailController,
                        keyType: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'emai can\'t be empty';
                          }
                          return null;
                        },
                        fillColor: Colors.white,
                        prefix: Icons.email,
                        label: 'Email',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      //Password TFF
                      BlocProvider(
                        create: (context) => ObscurePasswordCubit(),
                        child: BlocBuilder<ObscurePasswordCubit,ObscurePasswordState>(
                          builder:(context, state) {
                            return defaultFormField(
                              controller: passwordController,
                              keyType: TextInputType.visiblePassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password Can\'t be empty';
                                }
                                return null;
                              },
                              fillColor: Colors.white,
                              prefix: Icons.lock,
                              label: 'Password',
                              suffix: ObscurePasswordCubit.get(context).passwordIcon,

                              suffixPressed: () {
                                ObscurePasswordCubit.get(context).changePasswordVisibility();
                              },
                              isPassword: ObscurePasswordCubit.get(context).isPasswordShow,
                            );
                          },

                        ),
                      ),
                      const SizedBox(
                        height: 180,
                      ),
                      //Login Button
                      Container(
                        width: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xff134161),
                          // color: Color(0xff222a32),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ),
                            );
                            if (formKey.currentState!.validate()) {
                              if (kDebugMode) {
                                print('email: ${emailController.text}');
                              }
                              if (kDebugMode) {
                                print('password: ${passwordController.text}');
                              }
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              // color: Color(0xff222a32),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      //Register line
                      const SizedBox(
                        height: 50,
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
                            onPressed: () {},
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
