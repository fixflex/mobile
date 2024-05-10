import 'package:fix_flex/cubits/login_cubit/login_cubit.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_category_id_cubit/get_tasks_by_category_id_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../helper/secure_storage/secure_storage.dart';
import '../../screens/login_screen.dart';
import '../map_cubit/map_cubit.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  static LogoutCubit get(context) => BlocProvider.of(context);

void logout(BuildContext context) async {
  Fluttertoast.showToast(
      msg: 'Logout Successfully',
      fontSize: 20,
      backgroundColor: Colors.green);
  SecureStorage.deleteData(key: SecureKey.token);
  SecureStorage.deleteData(key: SecureKey.userId)
      .then((value) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  });
  CheckMyRoleCubit.get(context).resetCheckMyRoleCubit();
  GetTaskDetailsCubit.get(context).resetGetTaskDetailsCubit();
  GetTasksByCategoryIdCubit.get(context).resetGetTasksByCategoryIdCubit();
  GetTasksByUserIdCubit.get(context).resetGetTasksByUserIdCubit();
  PostTaskCubit.get(context).resetPostTaskCubit();
  BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
  CheckPersonalInformationCubit.get(context).resetCheckPersonalInformationCubit();
  GetMyDataCubit.get(context).resetGetMyDataCubit();
  GetUserDataCubit.get(context).resetGetUserDataCubit();
  UpdateProfilePictureCubit.get(context).resetUpdateProfilePictureCubit();
  LoginCubit.get(context).resetLoginCubit();
  RegisterCubit.get(context).resetRegisterCubit();
  MapCubit.get(context).resetLocationCubit(context);

  emit(LogoutSuccessState());
}
}
