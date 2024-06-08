import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';

part 'accept_offer_cash_state.dart';

class AcceptOfferCashCubit extends Cubit<AcceptOfferCashState> {
  AcceptOfferCashCubit() : super(AcceptOfferCashInitial());

  static AcceptOfferCashCubit get(context) => BlocProvider.of(context);
  var isLoading = false;

  Future<void> acceptOfferCash({required String offerId}) async {
    emit(AcceptOfferCashLoading());
    try {
      final response = await DioApiHelper.patchData(
        url: EndPoints.acceptOfferCash(offerId: offerId),
      );
      if (response.statusCode == 200) {
        emit(AcceptOfferCashSuccess());
      } else {
        emit(AcceptOfferCashFailure());
      }
    } catch (e) {
      emit(AcceptOfferCashFailure());
    }
  }
  void resetAcceptOfferCashCubit() {
    emit(AcceptOfferCashInitial());
  }
}
