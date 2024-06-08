import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'make_offer_state.dart';

class MakeOfferCubit extends Cubit<MakeOfferState> {
  MakeOfferCubit() : super(MakeOfferInitial());

  static MakeOfferCubit get(context) => BlocProvider.of(context);

  Future<void> makeOffer({
    required OfferDetails,
}) async {
    emit(MakeOfferLoading());
    try {
      final response = await DioApiHelper.postData(
        url: EndPoints.offers,
        data: {
          "taskId": OfferDetails.taskId,
          "price": OfferDetails.price,
          "message": OfferDetails.message,
        },
      );
      if (response.statusCode == 201) {
        emit(MakeOfferSuccess());
      } else if(response.statusCode == 400 && response.data['message'] == 'You_must_verify_your_phone_number'){
        emit(VerifyPhoneNumber());
      }else {
        emit(MakeOfferFailure());
      }
    } catch (e) {
      emit(MakeOfferFailure());
    }
  }

  void resetMakeOfferCubit() {
    emit(MakeOfferInitial());
  }


}
