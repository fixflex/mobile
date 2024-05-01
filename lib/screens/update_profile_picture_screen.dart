import 'dart:io';
import 'package:fix_flex/components/back_ground.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/users_cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';

class UpdateProfilePictureScreen extends StatelessWidget {
  const UpdateProfilePictureScreen({super.key});

  static const String id = 'UpdateProfilePictureScreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfilePictureCubit, UpdateProfilePictureState>(
        listener: (context, state) {
          if (state is UpdateProfilePictureLoading) {
            Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UpdateProfilePictureFailure) {
            SnackBar(
              content: Text('there is an error please try again'),
            );
          } else if (state is UpdateProfilePictureSuccess) {
            RegisterCubit.get(context).signUpFirstName.clear();
            RegisterCubit.get(context).signUpLastName.clear();
            RegisterCubit.get(context).signUpEmail.clear();
            RegisterCubit.get(context).signUpPhoneNumber.clear();
            RegisterCubit.get(context).signUpPassword.clear();
            RegisterCubit.get(context).signUpConfirmPassword.clear();
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          }
        },
        builder: (context, state) {
          var cubit = UpdateProfilePictureCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff134161),
              leading: Container(),
              centerTitle: true,
              title: Text('Select Profile Picture',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              actions: [
                TextButton(
                  onPressed: () {
                    cubit.updateProfilePicture(
                      id: SecureVariables.userId as String,
                      token: SecureVariables.token as String,
                      imageFile: cubit.image,
                    );
                  },
                  child: Text(
                    cubit.image != null ? 'Next >>' : 'Skip >>',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                BackGround(),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 50.0),
                      PopupMenuButton(
                        color: Colors.white,
                        offset: Offset(55, 140),
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
                              onTap: () {
                                cubit.pickImage(cubit.galleryOption);
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
                              onTap: () {
                                cubit.pickImage(cubit.cameraOption);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 100.0,
                              backgroundImage: cubit.image != null
                                  ? FileImage(cubit.image as File)
                                      as ImageProvider
                                  : Image.network(kDefaultUserImage).image,
                            ),
                            Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: Icon(CupertinoIcons.plus_circle_fill,
                                    size: 50.0, color: Colors.blue)),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        RegisterCubit.get(context).signUpFirstName.text +
                            ' ' +
                            RegisterCubit.get(context).signUpLastName.text,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      if (state is UpdateProfilePictureLoading)
                        Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
  }
}
