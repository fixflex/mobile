import 'package:fix_flex/constants/end_points/end_points.dart';
import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/user_model.dart';


part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitial());

  static GetUserDataCubit get(context) => BlocProvider.of(context);

  Future<void> getUserData(String userId) async {
    try {
      var response = await DioApiHelper.getData(
        url: EndPoints.getUserData(
          id: userId,
        ),
      );
      if(response.statusCode == 200) {
        Map<String,dynamic> userData = response.data['data'];
        if(userData.isEmpty) {
          emit(GetUserDataEmpty());
        } else {
          final List<UserDataModel> userDataList = [];
          UserDataModel userDataModel = UserDataModel.fromJson(userData);
          userDataList.add(userDataModel);
          emit(GetUserDataSuccess(userDataList: userDataList));
        }
      } else {
        emit(GetUserDataFailure());
      }
    } catch (e) {
      emit(GetUserDataFailure());
    }
  }
  ResetGetUserDataState() {
    emit(GetUserDataInitial());
  }
}
