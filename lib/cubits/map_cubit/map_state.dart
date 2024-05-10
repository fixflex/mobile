part of 'map_cubit.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}
final class MapLoading extends MapState {}
final class PermissionDenied  extends MapState {}
final class PermissionDeniedRestartTheApp  extends MapState {}
final class GetLocationFromBecomeATaskerSuccess  extends MapState {
  final Position position;
  GetLocationFromBecomeATaskerSuccess({required this.position});
}
final class GetLocationFromPostATaskSuccess  extends MapState {
  final Position? position;
  GetLocationFromPostATaskSuccess({this.position});
}
final class LocationServiceIsDisabled extends MapState {}
final class LocationServiceIsEnabled extends MapState {}
