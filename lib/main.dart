import 'package:flutter/material.dart';
import 'components/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helper/block_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
