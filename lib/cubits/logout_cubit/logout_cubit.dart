import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/end_points/end_points.dart';
import '../../helper/network/dio_api_helper.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  static LogoutCubit get(context) => BlocProvider.of(context);

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final response = await DioApiHelper.postData(
        url: EndPoints.logout);
    if (response.statusCode == 200) {
      emit(LogoutSuccessState(message: response.data["message"]));
    } else {
      emit(LogoutErrorState(error: response.data["message"]));
    }
  }
}
