import 'dart:async';
import 'package:fix_flex/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../helper/secure_storage/secure_keys/secure_variable.dart';
import 'home page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      if (SecureVariables.token != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff134161),
      child: Lottie.asset(
        "assets/images/fixFlex4.json",
      ),
    );
  }
}
