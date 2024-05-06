import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);


  getCurrentLocation(context) async {
    emit(MapLoading());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(LocationServiceIsDisabled());
    }else{
      emit(LocationServiceIsEnabled());
      emit(MapLoading());
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(PermissionDenied());
          return Future.error('Location permissions are denied');
        }
      }
    if (permission == LocationPermission.deniedForever) {
      emit(PermissionDeniedRestartTheApp());
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      emit(GetLocationSuccess(position: position));
    }
  }
}

onTapLocation(context) async {

}

}
