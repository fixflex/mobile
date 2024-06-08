import 'package:fix_flex/cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/create_new_chat_cubit/create_new_chat_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_chat_by_id_cubit/get_chat_by_id_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_messages_by_chat_id_cubit/get_messages_by_chat_id_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/post_message_cubit/post_message_cubit.dart';
import 'package:fix_flex/cubits/contact_us_cubit/contact_us_cubit.dart';
import 'package:fix_flex/cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:fix_flex/cubits/login_cubit/login_cubit.dart';
import 'package:fix_flex/cubits/obscure_password_cubit/obscure_password_cubit.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/date_radio_button_cubit/date_radio_button_cubit.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/place_radio_button_cubit/place_radio_button_cubit.dart';
import 'package:fix_flex/cubits/register_cubit/register_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/cansel_task_cubit/cansel_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/completed_task_cubit/completed_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/details_cubit/details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_address_cubit/get_address_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_category_id_cubit/get_tasks_by_category_id_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/make_offer_cubit/make_offer_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/make_task_open_cubit/make_task_open_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/search_task_cubit/search_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/title_cubit/title_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_my_data_cubit/get_my_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/rate_tasker_cubit/rate_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/verification/send_verification_code_cubit/send_verification_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../helper/secure_storage/secure_storage.dart';
import '../../screens/login_screen.dart';
import '../chating_cubits/get_my_chats_initial_cubit/get_my_chats_initial_cubit.dart';
import '../map_cubit/map_cubit.dart';
import '../tasks_cubits/accept_offer_cash_cubit/accept_offer_cash_cubit.dart';
import '../users_cubits/get_tasker_by_id_cubit/get_tasker_by_id_cubit.dart';
import '../users_cubits/verification/verify_phone_number_cubit/verify_phone_number_cubit.dart';
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
  BottomNavigationBarCubit.get(context).resetBottomNavBar();
  CreateNewChatCubit.get(context).resetCreateNewChatCubit();
  GetChatByIdCubit.get(context).resetGetChatByIdCubit();
  GetMessagesByChatIdCubit.get(context).resetGetMessagesByChatIdCubit();
  GetMyChatsCubit.get(context).resetGetMyChatsCubit();
  GetMyChatsInitialCubit.get(context).resetGetMyChatsInitialCubit();
  PostMessageCubit.get(context).resetPostMessageCubit();
  ContactUsCubit.get(context).resetContactUsCubit();
  GetCategoriesCubit.get(context).resetGetCategoriesCubit();
  LoginCubit.get(context).resetLoginCubit();
  MapCubit.get(context).resetLocationCubit(context);
  ObscurePasswordCubit.get(context).resetObscurePasswordCubit();
  DateRadioButtonCubit.get(context).resetDateRadioButtonCubit();
  PlaceRadioButtonCubit.get(context).resetPlaceRadioButtonCubit();
  RegisterCubit.get(context).resetRegisterCubit();
  AcceptOfferCashCubit.get(context).resetAcceptOfferCashCubit();
  BudgetCubit.get(context).resetBudgetCubit();
  CanselTaskCubit.get(context).resetCanselTaskCubit();
  CompletedTaskCubit.get(context).resetCompletedTaskCubit();
  DetailsCubit.get(context).resetDetailsCubit();
  GetAddressCubit.get(context).resetGetAddressCubit();
  GetTaskDetailsCubit.get(context).resetGetTaskDetailsCubit();
  GetTasksByCategoryIdCubit.get(context).resetGetTasksByCategoryIdCubit();
  GetTasksByUserIdCubit.get(context).resetGetTasksByUserIdCubit();
  MakeOfferCubit.get(context).resetMakeOfferCubit();
  MakeTaskOpenCubit.get(context).resetMakeTaskOpenCubit();
  PostTaskCubit.get(context).resetPostTaskCubit();
  TaskCubit.get(context).resetSearchTaskCubit();
  TitleCubit.get(context).resetTitleCubit();
  UploadTaskPhotosCubit.get(context).resetUploadTaskPhotosCubit();
  BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
  CheckMyRoleCubit.get(context).resetCheckMyRoleCubit();
  CheckPersonalInformationCubit.get(context).resetCheckPersonalInformationCubit();
  GetMyDataCubit.get(context).resetGetMyDataCubit();
  GetTaskerByIdCubit.get(context).resetGetTaskerByIdCubit();
  GetUserDataCubit.get(context).resetGetUserDataCubit();
  RateTaskerCubit.get(context).resetRate();
  UploadTaskPhotosCubit.get(context).resetUploadTaskPhotosCubit();
  UpdateProfilePictureCubit.get(context).resetUpdateProfilePictureCubit();
  SendVerificationCodeCubit.get(context).resetSendVerificationCode();
  VerifyPhoneNumberCubit.get(context).resetVerifyPhoneNumberCubit();
  emit(LogoutSuccessState());
}
}
