import 'package:fix_flex/models/my_chats_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'create_new_chat_state.dart';

class CreateNewChatCubit extends Cubit<CreateNewChatState> {
  CreateNewChatCubit() : super(CreateNewChatInitial());

  static CreateNewChatCubit get(context) => BlocProvider.of(context);
  MyChatsDataModel? newChatDataModel;

  Future<void> createNewChat({
    required String taskerId,
  }) async {
    emit(CreateNewChatLoading());
    try {
      final response = await DioApiHelper.postData(
        url: EndPoints.chats,
        data: {
          "tasker": taskerId,
        },
      );
      if (response.statusCode == 201) {
        final MyChatsDataModel myChatsDataModel = MyChatsDataModel.fromJson(response.data['data']);
        newChatDataModel = myChatsDataModel;
        emit(CreateNewChatSuccess( myChatsDataModel: myChatsDataModel));
      } else {
        emit(CreateNewChatFailure());
      }
    } catch (e) {
      emit(CreateNewChatFailure());
    }
  }

  void resetCreateNewChatCubit() {
    emit(CreateNewChatInitial());
  }
}
