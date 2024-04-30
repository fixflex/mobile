import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fix_flex/cubits/logout_cubit/logout_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/navigation_drawer.dart';
import '../cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const String id = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetTasksByUserIdCubit()),
        BlocProvider(create: (context) => BottomNavigationBarCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
      ],
      child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        builder: (context, state) {
          BottomNavigationBarCubit cubit =
              BottomNavigationBarCubit.get(context);
          return Scaffold(
            drawer: NavigationDrawerWidget(),
            body: cubit.screens[cubit.currentIndex],

            //Bottom Navigation Bar
            bottomNavigationBar: CurvedNavigationBar(
              items: cubit.navigationBarIcons,
              color: Color(0xff134161),
              index: cubit.currentIndex,
              backgroundColor: Colors.transparent,
              onTap: (index) {
                cubit.changeBottomNavBar(index,context);
              },
            ),
          );

        },
      ),
    );
  }
}
