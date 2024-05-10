import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../helper/secure_storage/secure_keys/secure_variable.dart';

part 'check_personal_information_state.dart';

class CheckPersonalInformationCubit extends Cubit<CheckPersonalInformationState> {
  CheckPersonalInformationCubit() : super(CheckPersonalInformationInitial());

  static CheckPersonalInformationCubit get(context) => BlocProvider.of(context);

  void checkPersonalInformation(String userId) {
    if(userId == SecureVariables.userId) {
      emit(MyPersonalInformation());
    } else {
      emit(OtherUserPersonalInformation());
    }
  }
  void resetCheckPersonalInformationCubit() {
    emit(CheckPersonalInformationInitial());
  }
}
