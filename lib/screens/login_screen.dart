import 'package:fix_flex/models/custom_clippers.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/default_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ClipPath(
                clipper: FirstClipper(),
                child: Container(color: const Color(0xffd7e0e6),),
              ),
          ClipPath(
            clipper: SecondClipper(),
            child: Container(color: const Color(0xff92d3f3),),
          ),
          ClipPath(
            clipper: ThirdClipper(),
            child: Container(color: const Color(0xff306686),),
          ),
          ClipPath(
            clipper: FourthClipper(),
            child: Container(color: const Color(0xff134161),),
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
                      defaultFormField(
                        controller: passwordController,
                        keyType: TextInputType.visiblePassword,
                        validate: (value) {
                          if(value!.isEmpty){
                            return 'Password Can\'t be empty';
                          }
                          return null;
                        },
                        fillColor: Colors.white,
                        prefix: Icons.lock,
                        label:'Password',
                        suffix: isPasswordShow? Icons.visibility :Icons.visibility_off,
                        suffixPressed: (){
                          setState(() {
                            isPasswordShow=!isPasswordShow;
                          });
                        },
                        isPassword: isPasswordShow,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            },),);
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
