import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/screens/become_a_tasker_screen.dart';
import 'package:fix_flex/screens/contact_us_screen.dart';
import 'package:fix_flex/screens/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constants.dart';
import '../cubits/logout_cubit/logout_cubit.dart';
import '../cubits/logout_cubit/logout_state.dart';
import '../cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import '../cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import '../cubits/users_cubits/get_tasker_by_id_cubit/get_tasker_by_id_cubit.dart';
import '../models/custom_clippers.dart';
import '../screens/personal_information_screen.dart';
import '../screens/who_are_we_screen.dart';

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
                child: BlocBuilder<GetMyDataCubit, GetMyDataState>(
                  builder: (context, dataState) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _handlePersonalInformationTap(context, dataState);
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
                                  dataState is GetMyDataSuccess
                                      ? dataState.myDataList[0].profilePicture?.url ?? kDefaultUserImage
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
                          dataState is GetMyDataSuccess
                              ? '${dataState.myDataList[0].FirstName} ${dataState.myDataList[0].LastName}'
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
                builder: (context, roleState) {
                  if (roleState is IamAUser) {
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
              title: Text("Contact us"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text("Who are we"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WhoAreWeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.terminal_rounded),
              title: Text("Terms and conditions"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TermsAndConditionsScreen()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.policy),
            //   title: Text("Privacy Policies"),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => PrivacyPoliciesScreen()));
            //   },
            // ),
            BlocBuilder<LogoutCubit, LogoutState>(builder: (context, state) {
              return ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Log out"),
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

  Future<void> _handlePersonalInformationTap(BuildContext context, GetMyDataState dataState) async {
    final userId = dataState is GetMyDataSuccess ? dataState.myDataList[0].uId : '';
    CheckPersonalInformationCubit.get(context).checkPersonalInformation(userId: userId);

    final roleState = BlocProvider.of<CheckMyRoleCubit>(context).state;
    if (roleState is IamATasker) {
      final taskerId = roleState.TaskerDataList[0].taskerId;
      await GetTaskerByIdCubit.get(context).getTaskerById(taskerId: taskerId);
    }

    Navigator.pushNamed(context, PersonalInformationScreen.id);
  }
}
