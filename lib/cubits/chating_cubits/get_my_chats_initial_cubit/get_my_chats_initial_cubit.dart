import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import '../../../models/my_chats_model.dart';

part 'get_my_chats_initial_state.dart';

class GetMyChatsInitialCubit extends Cubit<GetMyChatsInitialState> {
  GetMyChatsInitialCubit() : super(GetMyChatsInitialInitial());

  static GetMyChatsInitialCubit get(context) => BlocProvider.of(context);
  int results = 0;
  List<MyChatsDataModel> myChats = [];
  int index = 0;

  Future<void> getMyChats() async {
    emit(GetMyChatsInitialLoading());
    myChats.clear();
    try {
      final response = await DioApiHelper.getData(
        url: EndPoints.chats,
      );
      if (response.statusCode == 200) {
        List<dynamic> myChatsDataModel = response.data['data'];
        results = response.data['results'];
        if (myChatsDataModel.isEmpty) {
          emit(GetMyChatsInitialNoChats());
        } else {
          for (var chat in myChatsDataModel) {
            MyChatsDataModel myChat = MyChatsDataModel.fromJson(chat);
            myChats.add(myChat);
          }
          emit(GetMyChatsInitialSuccess(myChatsDataModel: myChats));
        }
      } else {
        emit(GetMyChatsInitialFailure());
      }
    } catch (e) {
      emit(GetMyChatsInitialFailure());
    }
  }


}
