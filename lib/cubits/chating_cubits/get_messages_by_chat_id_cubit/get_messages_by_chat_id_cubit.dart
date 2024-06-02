import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:fix_flex/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'get_messages_by_chat_id_state.dart';

class GetMessagesByChatIdCubit extends Cubit<GetMessagesByChatIdState> {
  GetMessagesByChatIdCubit() : super(GetMessagesByChatIdInitial());

  static GetMessagesByChatIdCubit get(context) => BlocProvider.of(context);

  Future<void> getMessagesByChatId({required String chatId}) async {
    emit(GetMessagesByChatIdLoading());
    try {
      final response = await DioApiHelper.getData(
          url: EndPoints.GetMessagesByChatId(id: chatId));
      if (response.statusCode == 200) {
        List<dynamic> messages = response.data['data'];
        if(messages.isEmpty){
          emit(NoMessages());
        }else{
          List<MessageModel> messagesList = [];
          for (var message in messages) {
            var theMessage = MessageModel.fromJson(message);
            messagesList.add(theMessage);
          }
          emit(GetMessagesByChatIdSuccess( messagesList: messagesList));
        }
      } else {
        emit(GetMessagesByChatIdFailure());
      }
    } catch (e) {
      emit(GetMessagesByChatIdFailure());
    }
  }
}
