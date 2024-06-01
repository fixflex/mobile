import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/screens/become_a_tasker_screen.dart';
import 'package:fix_flex/screens/contact_us_screen.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:fix_flex/screens/privacy_policies_screen.dart';
import 'package:fix_flex/screens/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubits/logout_cubit/logout_cubit.dart';
import '../cubits/logout_cubit/logout_state.dart';
import '../cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import '../cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import '../models/custom_clippers.dart';
import '../screens/who_are_we_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: BlocBuilder<CheckMyRoleCubit, CheckMyRoleState>(
            builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              ClipPath(
                clipper: SixthClipper(),
                child: Container(
                  padding: EdgeInsets.only(top: 80, bottom: 50),
                  decoration: BoxDecoration(
                    color: Color(0xff134161),
                  ),
                  child: BlocBuilder<GetMyDataCubit, GetMyDataState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              CheckPersonalInformationCubit.get(context)
                                  .checkPersonalInformation(
                                      userId: state is GetMyDataSuccess
                                          ? state.myDataList[0].uId
                                          : '');
                              Navigator.pushNamed(
                                  context, PersonalInformationScreen.id);
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 42,
                                  backgroundColor: Colors.white,
                                ),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    state is GetMyDataSuccess
                                        ? state.myDataList[0].profilePicture
                                                    ?.url !=
                                                null
                                            ? state.myDataList[0]
                                                .profilePicture!.url as String
                                            : kDefaultUserImage
                                        : kDefaultUserImage,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            state is GetMyDataSuccess
                                ? state.myDataList[0].FirstName +
                                    ' ' +
                                    state.myDataList[0].LastName
                                : 'User',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<CheckMyRoleCubit, CheckMyRoleState>(
                  builder: (context, state) {
                if (state is IamAUser) {
                  return ListTile(
                    leading: Icon(Icons.work),
                    title: Text("Become a tasker"),
                    onTap: () {
                      Navigator.of(context).pushNamed(BecomeATaskerScreen.id);
                    },
                  );
                } else {
                  return Container();
                }
              }),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text("contact us"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactUsScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.question_mark),
                title: Text("who are we"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WhoAreWeScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.terminal_rounded),
                title: Text("terms and conditions"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TermsAndConditionsScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.policy),
                title: Text("Privacy Policies "),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrivacyPoliciesScreen()));
                },
              ),
              BlocBuilder<LogoutCubit, LogoutState>(builder: (context, state) {
                return ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("log out"),
                  onTap: () {
                    LogoutCubit.get(context).logout(context);
                  },
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
