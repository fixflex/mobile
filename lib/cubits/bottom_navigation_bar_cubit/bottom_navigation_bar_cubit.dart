import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/homepage_components.dart';
import '../../screens/inbox_screen.dart';
import '../../screens/orders_screen.dart';
import '../../screens/search_screen.dart';
import '../../screens/user_profile.dart';
part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(BottomNavigationBarInitial());

  static BottomNavigationBarCubit get(context) => BlocProvider.of(context);
  // List<UserDataModel> usersDataList = [];

  int currentIndex = 0;
  final navigationBarIcons = <Widget>[
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.mail_outline,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.search_rounded,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.list_alt,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.person,
      size: 30,
      color: Colors.white,
    ),
  ];
  final screens = [
    HomePageComponents(),
    InBoxScreen(),
    SearchScreen(),
    OrdersScreen(),
    UserProfile(),
  ];

  Future<void> changeBottomNavBar(int index, context) async {
    currentIndex = index;
    if(index == 3){
       GetTasksByUserIdCubit.get(context).getTasksByUserId(userId: SecureVariables.userId);
    }else if(index == 1){
       GetMyChatsCubit.get(context).getMyChats(context);
      // if(GetMyChatsCubit.get(context).state is GetMyChatsSuccess){
      //   for (var chat in GetMyChatsCubit.get(context).myChats) {
      //     await GetUserDataCubit.get(context).getUserData(chat.tasker);
      //     // BlocBuilder<GetUserDataCubit,GetUserDataState>(builder: (context, state) {
      //     //   if(state is GetUserDataSuccess){
      //     //     usersDataList = state.userDataList;
      //     //   }else if(state is GetUserDataFailure){
      //     //     return Container();
      //     //   }return Container();
      //     // }
      //     // );
      //   }
      // }
      }
    emit(AppChangeBottomNavBar());
  }
}

