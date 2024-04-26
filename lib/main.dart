import 'package:fix_flex/models/image_model.dart';
import 'package:fix_flex/screens/category_screen.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/inbox_screen.dart';
import 'package:fix_flex/screens/login_screen.dart';
import 'package:fix_flex/screens/orders_screen.dart';
import 'package:fix_flex/screens/search_screen.dart';
import 'package:fix_flex/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'components/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/constants.dart';
import 'cubits/get_categories_cubit/get_categories_cubit.dart';
import 'helper/network/dio_api_helper.dart';
import 'helper/block_observer.dart';
import 'helper/secure_storage/secure_keys/secure_key.dart';
import 'helper/secure_storage/secure_keys/secure_variable.dart';
import 'helper/secure_storage/secure_storage.dart';
import 'models/category_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(ImageModelAdapter());
  // Hive.registerAdapter(CategoryModelAdapter());
  // await Hive.openBox<CategoryModel>(kCategoriesBox);
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
    return BlocProvider(
      create: (context) => GetCategoriesCubit()..getCategories(),
      child: MaterialApp(
        routes: routes(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      CategoryScreen.id: (context) => CategoryScreen(),
      HomeScreen.id: (context) => HomeScreen(),
      InBoxScreen.id: (context) => InBoxScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      OrdersScreen.id: (context) => OrdersScreen(),
      SearchScreen.id: (context) => SearchScreen(),
      UserProfile.id: (context) => UserProfile(),
    };
  }
}
