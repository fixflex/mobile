import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
import 'package:fix_flex/cubits/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_category_id_cubit/get_tasks_by_category_id_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';
import 'package:fix_flex/screens/become_a_tasker_screen.dart';
import 'package:fix_flex/screens/category_screen.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/inbox_screen.dart';
import 'package:fix_flex/screens/login_screen.dart';
import 'package:fix_flex/screens/make_an_offer_screen.dart';
import 'package:fix_flex/screens/make_task_request_screen.dart';
import 'package:fix_flex/screens/map_screen.dart';
import 'package:fix_flex/screens/orders_screen.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:fix_flex/screens/register_screen.dart';
import 'package:fix_flex/screens/search_screen.dart';
import 'package:fix_flex/screens/task_details_screen.dart';
import 'package:fix_flex/screens/update_profile_picture_screen.dart';
import 'package:fix_flex/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/get_categories_cubit/get_categories_cubit.dart';
import 'cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'helper/network/dio_api_helper.dart';
import 'helper/block_observer.dart';
import 'helper/secure_storage/secure_keys/secure_key.dart';
import 'helper/secure_storage/secure_keys/secure_variable.dart';
import 'helper/secure_storage/secure_storage.dart';

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
  SecureVariables.userId = await SecureStorage.getData(key: SecureKey.userId);
  // SecureVariables.role = await SecureStorage.getData(key: SecureKey.role);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetMyDataCubit()..getMyData(),),
          BlocProvider(create: (context) => GetUserDataCubit(),),
          BlocProvider(create: (context) => UpdateProfilePictureCubit(),),
          BlocProvider(create: (context) => RegisterCubit(),),
          BlocProvider(create: (context) => CheckMyRoleCubit()..checkMyRole(),),
          BlocProvider(create: (context) => BecomeATaskerCubit(),),
          BlocProvider(create: (context) => ObscurePasswordCubit(),),
          BlocProvider(create: (context) => CheckPersonalInformationCubit(),),
          BlocProvider(create: (context) => GetCategoriesCubit()..getCategories()),
          BlocProvider(create: (context) => GetTasksByCategoryIdCubit(),),
          BlocProvider(create: (context) => GetTaskDetailsCubit(),),
          BlocProvider(create: (context) => MapCubit(),),
        ],
        child: MaterialApp(
          routes: routes(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: PopScope(
              canPop: false,
              child: SplashScreen()),
        ));
  }

  Map<String, WidgetBuilder> routes() {
    return {
      CategoryScreen.id: (context) => CategoryScreen(),
      HomeScreen.id: (context) => HomeScreen(),
      InBoxScreen.id: (context) => InBoxScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      UpdateProfilePictureScreen.id: (context) => UpdateProfilePictureScreen(),
      PersonalInformationScreen.id: (context) => PersonalInformationScreen(),
      MakeTaskRequestScreen.id: (context) => MakeTaskRequestScreen(),
      BecomeATaskerScreen.id: (context) => BecomeATaskerScreen(),
      MakeAnOfferScreen.id: (context) => MakeAnOfferScreen(),
      RegisterScreen.id: (context) => RegisterScreen(),
      OrdersScreen.id: (context) => OrdersScreen(),
      SearchScreen.id: (context) => SearchScreen(),
      UserProfile.id: (context) => UserProfile(),
      MapScreen.id: (context) => MapScreen(),
      TaskDetailsScreen.id: (context) => TaskDetailsScreen(),
    };
  }
}
