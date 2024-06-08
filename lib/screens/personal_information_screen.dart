import 'package:fix_flex/components/back_ground.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_tasker_by_id_cubit/get_tasker_by_id_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../helper/secure_storage/secure_keys/secure_variable.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  static const String id = 'PersonalInformationScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfilePictureCubit, UpdateProfilePictureState>(
      builder: (context, state) {
        var cubit = UpdateProfilePictureCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: Text(
              'Personal Information',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Stack(
            children: [
              BackGround(),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      BlocBuilder<CheckPersonalInformationCubit,
                          CheckPersonalInformationState>(
                        builder: (context, state) {
                          if (state is MyPersonalInformation) {
                            return BlocBuilder<GetMyDataCubit, GetMyDataState>(
                                builder: (context, state) {
                                  var cubit = UpdateProfilePictureCubit.get(context);
                                  return Column(
                                    children: [
                                      SizedBox(height: 35.0),
                                      PopupMenuButton(
                                        color: Colors.white,
                                        offset: Offset(72, 99),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.image),
                                                  SizedBox(width: 10.0),
                                                  Text(cubit.galleryOption),
                                                ],
                                              ),
                                              onTap: () async {
                                                cubit.pickImage(cubit.galleryOption);
                                                await cubit.state is UpdateProfilePicturePickedImage ? cubit.updateProfilePicture(
                                                    id: SecureVariables.userId as String,
                                                    token: SecureVariables.token as String,
                                                    imageFile: cubit.image,
                                                    context: context,
                                                  ) : Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          PopupMenuItem(
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.camera_alt),
                                                  SizedBox(width: 10.0),
                                                  Text(cubit.cameraOption),
                                                ],
                                              ),
                                              onTap: () async {
                                                cubit.pickImage(cubit.cameraOption);
                                                await cubit.image != null ? cubit.updateProfilePicture(
                                                    id: SecureVariables.userId as String,
                                                    token: SecureVariables.token as String,
                                                    imageFile: cubit.image,
                                                    context: context,
                                                  ) : Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 70.0,
                                              backgroundImage: NetworkImage(
                                                state is GetMyDataSuccess && state.myDataList[0].profilePicture?.url != null
                                                    ? state.myDataList[0].profilePicture?.url as String
                                                    : kDefaultUserImage,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 2,
                                                right: 2,
                                                child: Icon(CupertinoIcons.pencil_circle_fill,
                                                    size: 40.0, color: Colors.blue)),
                                          ],
                                        ),
                                      ),
                                      PersonalInformationContent(
                                        context,
                                        cubit,
                                        state,
                                        userName: state is GetMyDataSuccess
                                            ? state.myDataList[0].FirstName.toUpperCase() +
                                            ' ' +
                                            state.myDataList[0].LastName.toUpperCase()
                                            : 'User Name',
                                        email: state is GetMyDataSuccess
                                            ? state.myDataList[0].email
                                            : 'Email Address',
                                        phoneNumber: state is GetMyDataSuccess && state.myDataList[0].phoneNumber != null
                                            ? state.myDataList[0].phoneNumber as String
                                            : 'Phone Number',
                                        role: state is GetMyDataSuccess
                                            ? CheckMyRoleCubit.get(context).state is IamATasker ? 'Tasker'
                                                : 'User'
                                            : 'Role',
                                        joinedDate: state is GetMyDataSuccess && state.myDataList[0].createdAt != null
                                            ? state.myDataList[0].createdAt as String
                                            : 'Joined Date',
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            return BlocBuilder<GetUserDataCubit, GetUserDataState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 35.0),
                                      CircleAvatar(
                                        radius: 70.0,
                                        backgroundImage: NetworkImage(
                                          state is GetUserDataSuccess && state.userDataList[0].profilePicture?.url != null
                                              ? state.userDataList[0].profilePicture?.url as String
                                              : kDefaultUserImage,
                                        ),
                                      ),
                                      PersonalInformationContent(
                                        context,
                                        cubit,
                                        state,
                                        userName: state is GetUserDataSuccess
                                            ? state.userDataList[0].FirstName.toUpperCase() +
                                            ' ' +
                                            state.userDataList[0].LastName.toUpperCase()
                                            : 'User Name',
                                        email: state is GetUserDataSuccess
                                            ? state.userDataList[0].email
                                            : 'Email Address',
                                        phoneNumber: state is GetUserDataSuccess && state.userDataList[0].phoneNumber != null
                                            ? state.userDataList[0].phoneNumber as String
                                            : 'Phone Number',
                                        role: state is GetUserDataSuccess
                                            ? state.userDataList[0].role == 'USER' ? 'User'
                                                : 'Tasker'
                                            : 'Role',
                                        joinedDate: state is GetUserDataSuccess && state.userDataList[0].createdAt != null
                                            ? state.userDataList[0].createdAt as String
                                            : 'Joined Date',
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Column PersonalInformationContent(
    BuildContext context,
    UpdateProfilePictureCubit cubit,
    state, {
    required String userName,
    required String role,
    required String email,
    required String phoneNumber,
    required String joinedDate,
  }) {
    return Column(
        children: [
          SizedBox(height: 25.0),
          Text(
            userName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          BlocBuilder<GetTaskerByIdCubit,GetTaskerByIdState>(
              builder: (context,state) {
                if (state is GetTaskerByIdSuccess) {
                 return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBarIndicator(
                      itemBuilder: (context, index) {
                        return Icon(
                          size: 30,
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      itemSize: 30,
                      rating: state.tasker.ratingAverage.toDouble(),
                    ),
                    Text(
                      '(${state.tasker.ratingQuantity})',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
                }else{
                  return Container();
                }
              }
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              role,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 25.0),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.white,
            ),
            title: Text(
              email,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 25.0),
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.white,
            ),
            title: Text(
              phoneNumber,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 25.0),
          ),
          ListTile(
            leading: Icon(
              Icons.date_range,
              color: Colors.white,
            ),
            title: Text(
              state is GetMyDataSuccess
                  ? DateFormat.yMMMMd()
                      .format(DateTime.parse(joinedDate))
                  : 'Joined Date',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  }
}
