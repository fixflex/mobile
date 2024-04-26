import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/logout_cubit/logout_cubit.dart';
import '../cubits/logout_cubit/logout_state.dart';
import '../models/custom_clippers.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ClipPath(
              clipper: SixthClipper(),
              child: Container(
                padding: EdgeInsets.only(top: 80, bottom: 50),
                decoration: BoxDecoration(
                  color: Color(0xff134161),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            'assets/images/person.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Fix Flex", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("register as a tasker"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("contact us"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text("who are we"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.terminal_rounded),
              title: Text("terms and conditions"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text("Privacy Policies "),
              onTap: () {},
            ),
           BlocBuilder<LogoutCubit,LogoutState>(
             builder: (context, state) {
              return ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("log out"),
                onTap: () {
                  LogoutCubit.get(context).logout(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
