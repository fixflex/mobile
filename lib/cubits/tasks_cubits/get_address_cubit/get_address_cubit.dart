import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:meta/meta.dart';

part 'get_address_state.dart';

class GetAddressCubit extends Cubit<GetAddressState> {
  GetAddressCubit() : super(GetAddressInitial());

  static GetAddressCubit get(context) => BlocProvider.of(context);
  List<Placemark> placemarks = [];

  Future<void> getAddress(List<dynamic>? coordinates) async {
    if (coordinates != null && coordinates.isNotEmpty) {

      if (coordinates.length == 2) {
        var latitude = coordinates[1];
        var longitude = coordinates[0];

        if (latitude == 0 && longitude == 0) {
          emit(GetAddressFailure());
          return;
        }
        placemarks = await placemarkFromCoordinates(
            double.parse(latitude.toString()), double.parse(longitude.toString()));
        emit(GetAddressSuccess());
      }
    }
  }
void resetGetAddressCubit() {
    placemarks = [];
    emit(GetAddressInitial());
  }

}
