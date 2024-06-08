import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../helper/secure_storage/secure_keys/secure_key.dart';
import '../../../helper/secure_storage/secure_storage.dart';

part 'get_messages_by_chat_id_state.dart';

class GetMessagesByChatIdCubit extends Cubit<GetMessagesByChatIdState> {
  GetMessagesByChatIdCubit() : super(GetMessagesByChatIdInitial());

  static GetMessagesByChatIdCubit get(context) => BlocProvider.of(context);

  Future<void> getMessagesByChatId({required String chatId}) async {
    emit(GetMessagesByChatIdLoading());
    try {
      final response = await DioApiHelper.getData(
          url: EndPoints.getMessagesByChatId(id: chatId));
      if (response.statusCode == 200) {
        List<dynamic> messages = response.data['data'];
        List<MessageModel> messagesList = [];
        for (var message in messages) {
          var theMessage = MessageModel.fromJson(message);
          messagesList.add(theMessage);
        }
        var userId = await SecureStorage.getData(key: SecureKey.userId);
        emit(GetMessagesByChatIdSuccess( messagesList: messagesList , userId: userId));
      } else {
        emit(GetMessagesByChatIdFailure());
      }
    } catch (e) {
      emit(GetMessagesByChatIdFailure());
    }
  }
  Future <void> getMessagesByChatIdForWebSocket({required message}) async {
    emit(GetMessagesByChatIdLoading());
    try {
      var theMessage = MessageModel.fromJson(message);
      var userId = await SecureStorage.getData(key: SecureKey.userId);
      emit(GetMessagesByChatIdSuccess( messagesList: [theMessage] , userId: userId));
    } catch (e) {
      emit(GetMessagesByChatIdFailure());
    }
  }

  void resetGetMessagesByChatIdCubit() {
    emit(GetMessagesByChatIdInitial());
  }
}
