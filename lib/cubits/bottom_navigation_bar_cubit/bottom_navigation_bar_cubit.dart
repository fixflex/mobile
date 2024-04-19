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

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBar());
  }
}
