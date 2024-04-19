import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fix_flex/screens/search_screen.dart';
import 'package:fix_flex/screens/user_profile.dart';
import 'package:flutter/material.dart';
import '../components/homepage_components.dart';
import '../components/navigation_drawer.dart';
import 'inbox_screen.dart';
import 'orders_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
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

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
        drawer: NavigationDrawerWidget(),
        body: screens[index],
      
        //Bottom Navigation Bar
        bottomNavigationBar: CurvedNavigationBar(
          items: navigationBarIcons,
          color: Color(0xff134161),
          index: index,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
    );
  }
}

