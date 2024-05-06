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
  CheckMyRoleCubit.get(context).ResetCheckMyRoleState();
  GetTaskDetailsCubit.get(context).ResetGetTaskDetailsState();
  GetTasksByCategoryIdCubit.get(context).ResetGetTasksByCategoryIdState();
  GetTasksByUserIdCubit.get(context).ResetGetTasksByUserIdState();
  PostTaskCubit.get(context).ResetPostTaskState();
  BecomeATaskerCubit.get(context).ReseatBecomeATaskerState();
  CheckPersonalInformationCubit.get(context).ResetCheckPersonalInformationState();
  GetMyDataCubit.get(context).ResetGetMyDataState();
  GetUserDataCubit.get(context).ResetGetUserDataState();
  UpdateProfilePictureCubit.get(context).ResetUpdateProfilePictureState();
  LoginCubit.get(context).ResetLoginState();
  RegisterCubit.get(context).ResetRegisterCubit();
  emit(LogoutSuccessState());
}
}
