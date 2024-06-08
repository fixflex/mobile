import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'post_message_state.dart';

class PostMessageCubit extends Cubit<PostMessageState> {
  PostMessageCubit() : super(PostMessageInitial());

  static PostMessageCubit get(context) => BlocProvider.of(context);

  Future<void> postMessage({required String message,required String chatId}) async {
    emit(PostMessageLoading());
    try {
      final response = await DioApiHelper.postData(url: EndPoints.messages,
          data: {
        "message": message,
        "chatId": chatId,
      });
      if (response.statusCode == 201) {
        emit(PostMessageSuccess());
      } else {
        emit(PostMessageFailure());
      }
    } catch (e) {
      emit(PostMessageFailure());
    }
  }

  void resetPostMessageCubit() {
    emit(PostMessageInitial());
  }
}
