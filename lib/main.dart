import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/inbox_screen.dart';
import 'package:fix_flex/screens/login_screen.dart';
import 'package:fix_flex/screens/orders_screen.dart';
import 'package:fix_flex/screens/search_screen.dart';
import 'package:fix_flex/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'components/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helper/network/dio_api_helper.dart';
import 'helper/block_observer.dart';
import 'helper/secure_storage/secure_keys/secure_key.dart';
import 'helper/secure_storage/secure_keys/secure_variable.dart';
import 'helper/secure_storage/secure_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SecureStorage.init();
  await DioApiHelper.init();
  Bloc.observer = MyBlocObserver();

  SecureVariables.token = await SecureStorage.getData(key: SecureKey.token);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: routes(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }



  Map<String, WidgetBuilder> routes() {
    return {
      HomeScreen.id: (context) =>  HomeScreen(),
      InBoxScreen.id: (context) => InBoxScreen(),
      LoginScreen.id: (context) =>  LoginScreen(),
      OrdersScreen.id: (context) =>  OrdersScreen(),
      SearchScreen.id: (context) =>  SearchScreen(),
      UserProfile.id: (context) =>  UserProfile(),
    };
  }
}