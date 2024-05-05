import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'get_my_data_state.dart';

class GetMyDataCubit extends Cubit<GetMyDataState> {
  GetMyDataCubit() : super(GetMyDataInitial());

  static GetMyDataCubit get(context) => BlocProvider.of(context);

  Future<void> getMyData() async {
    try {
      var response = await DioApiHelper.getData(
        url: EndPoints.getMyData(
          id: SecureVariables.userId as String,
        ),
      );
      if(response.statusCode == 200) {
        Map<String,dynamic> myData = response.data['data'];
        if(myData.isEmpty) {
          emit(GetMyDataEmpty());
        } else {
          final List<UserDataModel> myDataList = [];
          UserDataModel userDataModel = UserDataModel.fromJson(myData);
          myDataList.add(userDataModel);
          emit(GetMyDataSuccess(myDataList: myDataList));
        }
      } else {
        emit(GetMyDataFailure());
      }
    } catch (e) {
      emit(GetMyDataFailure());
    }
  }
}
