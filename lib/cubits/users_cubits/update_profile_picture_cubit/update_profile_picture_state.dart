part of 'update_profile_picture_cubit.dart';

@immutable
sealed class UpdateProfilePictureState {}

final class UpdateProfilePictureInitial extends UpdateProfilePictureState {}
final class UpdateProfilePictureLoading extends UpdateProfilePictureState {}
final class UpdateProfilePictureSuccess extends UpdateProfilePictureState {}
final class UpdateProfilePictureFailure extends UpdateProfilePictureState {}
final class UpdateProfilePicturePickedImage extends UpdateProfilePictureState {}
final class ImageClicked extends UpdateProfilePictureState {}
