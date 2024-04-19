import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/navigation_drawer.dart';
import '../cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(
          create: (context) => BottomNavigationBarCubit(),
          child: BlocConsumer<BottomNavigationBarCubit,BottomNavigationBarState>(
            listener: (context, state) {},
            builder:(context, state) {

              BottomNavigationBarCubit cubit = BottomNavigationBarCubit.get(context);

              return  Scaffold(
                drawer: NavigationDrawerWidget(),
                body: cubit.screens[cubit.currentIndex],

                //Bottom Navigation Bar
                bottomNavigationBar: CurvedNavigationBar(
                  items: cubit.navigationBarIcons,
                  color: Color(0xff134161),
                  index: cubit.currentIndex,
                  backgroundColor: Colors.transparent,
                  onTap: (index) {
                    cubit.changeBottomNavBar(index);
                  },
                ),
              );
            },
          ),
        );
  }
}

