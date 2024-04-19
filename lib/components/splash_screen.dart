import 'dart:async';
import 'package:fix_flex/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),
            () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => LoginScreen()));
        }
    );
  }
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff134161),
      child: Lottie.asset("assets/images/fixFlex4.json",
      ),
    );
  }
}
