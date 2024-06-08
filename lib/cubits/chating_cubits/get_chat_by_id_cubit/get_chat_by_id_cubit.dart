import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';


part 'get_chat_by_id_state.dart';

class GetChatByIdCubit extends Cubit<GetChatByIdState> {
  GetChatByIdCubit() : super(GetChatByIdInitial());

static GetChatByIdCubit get(context) => BlocProvider.of(context);
String chatName ='Chat Name';

  Future<void> getChatById({
    required String id,
}) async{
    emit(GetChatByIdLoading());
    try {
      final response = await DioApiHelper.getData(
          url:EndPoints.getChatById(id: id)
      );
      if (response.statusCode == 200) {
        // final MyChatsModel myChatsModel = MyChatsModel.fromJson(response.data);
        emit(GetChatByIdSuccess());
      } else {
        emit(GetChatByIdFailure());
      }

    } catch (e) {
      emit(GetChatByIdFailure());
    }
  }
}
