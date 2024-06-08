import 'package:fix_flex/components/add_task_photos.dart';
import 'package:fix_flex/components/choose_time_of_task.dart';
import 'package:fix_flex/components/offer_message.dart';
import 'package:fix_flex/components/phone_number_verification.dart';
import 'package:fix_flex/components/select_a_budget.dart';
import 'package:fix_flex/components/task_place.dart';
import 'package:fix_flex/cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/create_new_chat_cubit/create_new_chat_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_messages_by_chat_id_cubit/get_messages_by_chat_id_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_my_chats_initial_cubit/get_my_chats_initial_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/post_message_cubit/post_message_cubit.dart';
import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
import 'package:fix_flex/cubits/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/date_radio_button_cubit/date_radio_button_cubit.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/accept_offer_cash_cubit/accept_offer_cash_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/cansel_task_cubit/cansel_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/completed_task_cubit/completed_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_address_cubit/get_address_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_category_id_cubit/get_tasks_by_category_id_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/make_offer_cubit/make_offer_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/make_task_open_cubit/make_task_open_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_tasker_by_id_cubit/get_tasker_by_id_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/rate_tasker_cubit/rate_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_phone_number_cubit/update_phone_number_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/verification/verify_phone_number_cubit/verify_phone_number_cubit.dart';
import 'package:fix_flex/screens/become_a_tasker_screen.dart';
import 'package:fix_flex/screens/category_screen.dart';
import 'package:fix_flex/screens/chating_screen.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:fix_flex/screens/inbox_screen.dart';
import 'package:fix_flex/screens/login_screen.dart';
import 'package:fix_flex/screens/make_an_offer_screen.dart';
import 'package:fix_flex/screens/orders_screen.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:fix_flex/screens/post_a_task_screen.dart';
import 'package:fix_flex/screens/rating_screen.dart';
import 'package:fix_flex/screens/register_screen.dart';
import 'package:fix_flex/screens/search_screen.dart';
import 'package:fix_flex/screens/task_details_screen.dart';
import 'package:fix_flex/screens/update_profile_picture_screen.dart';
import 'package:fix_flex/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/chating_cubits/get_chat_by_id_cubit/get_chat_by_id_cubit.dart';
import 'cubits/get_categories_cubit/get_categories_cubit.dart';
import 'cubits/radio_buttons_cubit/place_radio_button_cubit/place_radio_button_cubit.dart';
import 'cubits/tasks_cubits/details_cubit/details_cubit.dart';
import 'cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'cubits/tasks_cubits/search_task_cubit/search_task_cubit.dart';
import 'cubits/tasks_cubits/title_cubit/title_cubit.dart';
import 'cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'cubits/users_cubits/verification/send_verification_code_cubit/send_verification_code_cubit.dart';
import 'helper/block_observer.dart';
import 'helper/network/dio_api_helper.dart';
import 'helper/secure_storage/secure_keys/secure_key.dart';
import 'helper/secure_storage/secure_keys/secure_variable.dart';
import 'helper/secure_storage/secure_storage.dart';
import 'helper/web_socket/socket_service.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecureStorage.init();
  await DioApiHelper.init();
  Bloc.observer = MyBlocObserver();

  SecureVariables.token = await SecureStorage.getData(key: SecureKey.token);
  SecureVariables.userId = await SecureStorage.getData(key: SecureKey.userId);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetMyChatsInitialCubit(),
          ),
          BlocListener<GetMyChatsInitialCubit,GetMyChatsInitialState>(listener: (context, state) {
            if(state is GetMyChatsInitialSuccess){
              List chatsId = [];
              for(int i = 0; i < state.myChatsDataModel.length; i++){
                chatsId.add(state.myChatsDataModel[i].id);
              }
              connectAndListen(chatsId: chatsId);
            }else if(state is GetMyChatsInitialNoChats){
              connectAndListen(chatsId: []);
            }
          },),
          BlocProvider(
            create: (context) => GetMyDataCubit()..getMyData(),
          ),
          BlocListener<GetMyDataCubit,GetMyDataState>(listener:
          (context, state) {
            if(state is GetMyDataSuccess){
              GetMyChatsInitialCubit.get(context).getMyChats();
            }
          },
          ),
          BlocProvider(
            create: (context) => GetUserDataCubit(),
          ),
          BlocProvider(
            create: (context) => BottomNavigationBarCubit(),
          ),
          BlocProvider(
            create: (context) => UpdateProfilePictureCubit(),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider(
            create: (context) => CheckMyRoleCubit()..checkMyRole(),
          ),
          BlocProvider(
            create: (context) => GetTaskerByIdCubit(),
          ),
          BlocProvider(
            create: (context) => BecomeATaskerCubit(),
          ),
          BlocProvider(
            create: (context) => GetTasksByUserIdCubit(),
          ),
          BlocProvider(
            create: (context) => ObscurePasswordCubit(),
          ),
          BlocProvider(
            create: (context) => CheckPersonalInformationCubit(),
          ),
          BlocProvider(
              create: (context) => GetCategoriesCubit()..getCategories()),
          BlocProvider(
            create: (context) => GetTasksByCategoryIdCubit(),
          ),
          BlocProvider(
            create: (context) => GetTaskDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => MapCubit(),
          ),
          BlocProvider(
            create: (context) => PostTaskCubit(),
          ),
          BlocProvider(
            create: (context) => DateRadioButtonCubit(),
          ),
          BlocProvider(
            create: (context) => PlaceRadioButtonCubit(),
          ),
          BlocProvider(
            create: (context) => UploadTaskPhotosCubit(),
          ),
          BlocProvider(
            create: (context) => BudgetCubit(),
          ),
          BlocProvider(
            create: (context) => GetAddressCubit(),
          ),
          BlocProvider(
            create: (context) => TitleCubit(),
          ),
          BlocProvider(
            create: (context) => DetailsCubit(),
          ),
          BlocProvider(
            create: (context) => SendVerificationCodeCubit(),
          ),
          BlocProvider(
            create: (context) => VerifyPhoneNumberCubit(),
          ),
          BlocProvider(
            create: (context) => UpdatePhoneNumberCubit(),
          ),
          BlocProvider(
            create: (context) => MakeOfferCubit(),
          ),
          BlocProvider(
            create: (context) => GetChatByIdCubit(),
          ),
          BlocProvider(
            create: (context) => TaskCubit(),
          ),
          BlocProvider(
            create: (context) => GetMyChatsCubit(),
          ),
          BlocProvider(
            create: (context) => GetMessagesByChatIdCubit(),
          ),
          BlocProvider(
            create: (context) => PostMessageCubit(),
          ),
          BlocProvider(
            create: (context) => AcceptOfferCashCubit(),
          ),
          BlocProvider(
            create: (context) => CreateNewChatCubit(),
          ),
          BlocProvider(
            create: (context) => CanselTaskCubit(),
          ),
          BlocProvider(
            create: (context) => MakeTaskOpenCubit(),
          ),
          BlocProvider(
            create: (context) => CompletedTaskCubit(),
          ),
          BlocProvider(
            create: (context) => RateTaskerCubit(),
          ),
        ],
        child: MaterialApp(
          routes: routes(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: PopScope(canPop: false, child: SplashScreen()),
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
      PostATaskScreen.id: (context) => PostATaskScreen(),
      BecomeATaskerScreen.id: (context) => BecomeATaskerScreen(),
      MakeAnOfferScreen.id: (context) => MakeAnOfferScreen(),
      RegisterScreen.id: (context) => RegisterScreen(),
      OrdersScreen.id: (context) => OrdersScreen(),
      SearchScreen.id: (context) => SearchScreen(),
      UserProfile.id: (context) => UserProfile(),
      TaskDetailsScreen.id: (context) => TaskDetailsScreen(),
      ChooseTimeOfTask.id: (context) => ChooseTimeOfTask(),
      TaskPlace.id: (context) => TaskPlace(),
      AddTaskPhotos.id: (context) => AddTaskPhotos(),
      SelectABudget.id: (context) => SelectABudget(),
      OfferMessage.id: (context) => OfferMessage(),
      PhoneNumberVerification.id: (context) => PhoneNumberVerification(),
      ChatingScreen.id: (context) => ChatingScreen(),
      RatingScreen.id: (context) => RatingScreen(),
    };
  }
}
