part of 'upload_task_photos_cubit.dart';

@immutable
sealed class UploadTaskPhotosState {}

final class UploadTaskPhotosInitial extends UploadTaskPhotosState {}
final class UploadTaskPhotosLoading extends UploadTaskPhotosState {}
final class UploadTaskPhotosSuccess extends UploadTaskPhotosState {}
final class UploadTaskPhotosFailure extends UploadTaskPhotosState {}
final class UploadTaskPhotosPickedImage extends UploadTaskPhotosState {}
final class ImageIsAlreadyExist extends UploadTaskPhotosState {}
final class ImageRemoved extends UploadTaskPhotosState {}
final class ImageClicked extends UploadTaskPhotosState {}

