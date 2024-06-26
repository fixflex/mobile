import 'package:fix_flex/cubits/logout_cubit/logout_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/screens/contact_us_screen.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/list_tile_button.dart';
import '../constants/constants.dart';
import '../cubits/logout_cubit/logout_state.dart';
import '../cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import '../helper/secure_storage/secure_keys/secure_variable.dart';
import '../models/custom_clippers.dart';
import '../models/list_tile_model.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  static const String id = 'UserProfile';

  final List<ListTileModel> listTileOptions = [
    // ListTileModel(
    //   leading: Icons.credit_card,
    //   title: 'Payment Options',
    //   trailing: Icons.arrow_forward_ios,
    //   onTap: (BuildContext context) {
    //     print('Payment Options');
    //   },
    // ),
    // ListTileModel(
    //   leading: Icons.notifications,
    //   title: 'Notifications',
    //   trailing: Icons.arrow_forward_ios,
    //   onTap: (BuildContext context) {
    //     print('Notifications');
    //   },
    // ),
    ListTileModel(
      leading: Icons.lock_person,
      title: 'Personal Information',
      trailing: Icons.arrow_forward_ios,
      onTap: (BuildContext context) async {
         CheckPersonalInformationCubit.get(context)
            .checkPersonalInformation(userId: SecureVariables.userId as String);
        await CheckMyRoleCubit.get(context).checkMyRole();
        Navigator.pushNamed(context, PersonalInformationScreen.id);
      },
    ),
    // ListTileModel(
    //   leading: Icons.help,
    //   title: 'Help',
    //   trailing: Icons.arrow_forward_ios,
    //   onTap: (BuildContext context) {
    //     print('Help');
    //   },
    // ),
    ListTileModel(
      leading: Icons.message,
      title: 'Contact Us',
      trailing: Icons.arrow_forward_ios,
      onTap: (BuildContext context) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactUsScreen()));
      },
    ),
    // ListTileModel(
    //   leading: Icons.policy,
    //   title: 'Policy',
    //   trailing: Icons.arrow_forward_ios,
    //   onTap: (BuildContext context) {
    //     Navigator.of(context).push(
    //         MaterialPageRoute(builder: (context) => PrivacyPoliciesScreen()));
    //   },
    // ),
    ListTileModel(
      leading: Icons.logout,
      title: 'Log Out',
      trailing: Icons.arrow_forward_ios,
      onTap: (BuildContext context) {
        LogoutCubit.get(context).logout(context);
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<GetMyDataCubit, GetMyDataState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipPath(
                      clipper: FifthClipper(),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Color(0xff134161),
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 20,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 43,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 230,
                                  child: Text(
                                    state is GetMyDataSuccess
                                        ? state.myDataList[0].FirstName +
                                            ' ' +
                                            state.myDataList[0].LastName
                                        : 'User',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Cairo, Egypt PlaPla',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'ACCOUNT SETTINGS',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.all(0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTileButton(
                                  onTap: () {
                                    final onTap = listTileOptions[index].onTap;
                                    if (onTap != null) {
                                      onTap(context);
                                    }
                                  },
                                  listTileModel: listTileOptions[index],
                                );
                              },
                              itemCount: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                                bottom: 8,
                              ),
                              child: Text(
                                'HELP & SUPPORT',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            ListView.builder(
                              padding: EdgeInsets.all(0),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTileButton(
                                  listTileModel: listTileOptions[index + 1],
                                  onTap: () {
                                    final onTap =
                                        listTileOptions[index + 1].onTap;
                                    if (onTap != null) {
                                      onTap(context);
                                    }
                                  },
                                );
                              },
                              itemCount: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                                bottom: 8,
                              ),
                              child: Text(
                                'SAFETY',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            BlocBuilder<LogoutCubit, LogoutState>(
                              builder: (context, state) {
                                return ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTileButton(
                                      listTileModel: listTileOptions[index + 2],
                                      onTap: () {
                                        final onTap =
                                            listTileOptions[index + 2].onTap;
                                        if (onTap != null) {
                                          onTap(context);
                                        }
                                      },
                                    );
                                  },
                                  itemCount: 1,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: 220,
              child: Container(
                width: 120,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}