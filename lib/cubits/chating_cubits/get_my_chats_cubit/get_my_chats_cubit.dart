import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/models/my_chats_model.dart';
import 'package:fix_flex/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import '../../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../../helper/secure_storage/secure_storage.dart';

part 'get_my_chats_state.dart';

class GetMyChatsCubit extends Cubit<GetMyChatsState> {
  GetMyChatsCubit() : super(GetMyChatsInitial());

  static GetMyChatsCubit get(context) => BlocProvider.of(context);
  int results = 0;
  List<UserDataModel> chatsHolders = [];
  List<MyChatsDataModel> myChats = [];
  List<StreamSubscription> _subscriptions = [];
  int index = 0;

  @override
  Future<void> close() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    return super.close();
  }

  Future<void> getMyChats(context) async {
    emit(GetMyChatsLoading());
    final myId = await SecureStorage.getData(key: SecureKey.userId);
    myChats.clear();
    chatsHolders.clear();
    try {
      final response = await DioApiHelper.getData(
        url: EndPoints.chats,
      );
      if (response.statusCode == 200) {
        List<dynamic> myChatsDataModel = response.data['data'];
        results = response.data['results'];
        if (myChatsDataModel.isEmpty) {
          emit(NoChats());
        } else {
          for (var chat in myChatsDataModel) {
            MyChatsDataModel myChat = MyChatsDataModel.fromJson(chat);
            if (myChat.user == myId) {
              await fetchUserData(context, myChat.tasker);
            } else {
            await fetchUserData(context, myChat.user);
            }
            myChats.add(myChat);
          }
          emit(GetMyChatsSuccess(chatsHolders: List.from(chatsHolders), myChatsDataModel: myChats));
        }
      } else {
        emit(GetMyChatsFailure());
      }
    } catch (e) {
      emit(GetMyChatsFailure());
    }
  }

  Future<void> fetchUserData(context, String userId) async {
    final getUserDataCubit = GetUserDataCubit.get(context);
    final completer = Completer<void>();
    final subscription = getUserDataCubit.stream.listen((state) {
      if (state is GetUserDataSuccess) {
        chatsHolders.add(state.userDataList[0]);
        completer.complete();
      } else if (state is GetUserDataFailure) {
        completer.completeError('Failed to fetch user data');
      }
    });

    _subscriptions.add(subscription);

    getUserDataCubit.getUserData(userId);

    await completer.future;
    await subscription.cancel();
    _subscriptions.remove(subscription);
  }

  void resetGetMyChatsCubit() {
    emit(GetMyChatsInitial());
    chatsHolders.clear();
    myChats.clear();
    _subscriptions.clear();
    index = 0;
  }
}
