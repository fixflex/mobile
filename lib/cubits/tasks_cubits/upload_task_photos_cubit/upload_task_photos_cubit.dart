import 'package:dio/dio.dart';
import 'package:fix_flex/cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../../../constants/end_points/end_points.dart';
import '../../../helper/network/dio_api_helper.dart';
import 'package:http_parser/http_parser.dart';
import '../../../widgets/add_photos_button.dart';
import '../../../widgets/image_box_with_close_icon.dart';

part 'upload_task_photos_state.dart';

class UploadTaskPhotosCubit extends Cubit<UploadTaskPhotosState> {
  UploadTaskPhotosCubit() : super(UploadTaskPhotosInitial());

  static UploadTaskPhotosCubit get(context) => BlocProvider.of(context);

  List<Widget> images = [
    AddPhotosButton(),
  ];
  List<String> existsImagesCheck = [];
  List<File?> imagesFiles = [];
  final ImagePicker imagePicker = ImagePicker();

  Future<void> uploadTaskPictures() async {
    emit(UploadTaskPhotosLoading());
    try {
      final formData = FormData();

      for (var image in imagesFiles) {
        if (image != null) {
          formData.files.add(MapEntry(
              'image',
              await MultipartFile.fromFile(image.path,
                  filename: basename(image.path),
                  contentType: MediaType('image', 'jpeg'))));
        }
      }

      final response = await DioApiHelper.patchData(
        url: EndPoints.uploadTaskPhotos(
            id: PostTaskCubit.taskDetailsList[0].id as String),
        data: formData,
      );
      if (response.statusCode == 200) {
        emit(UploadTaskPhotosSuccess());
        imagesFiles.clear();
      } else {
        emit(UploadTaskPhotosFailure());
      }
    } catch (e) {
      emit(UploadTaskPhotosFailure());
    }
  }

  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> pickedImages =
          await imagePicker.pickMultiImage(limit: 6);
      if (pickedImages.isNotEmpty) {
        for (var image in pickedImages) {
          final fileName = basename(image.path);
          if (!existsImagesCheck.contains(fileName)) {
            if (existsImagesCheck.length < 6) {
              existsImagesCheck.add(fileName);
              imagesFiles.add(File(image.path));
              images.add(ImageBoxWithCloseIcon(filePath: File(image.path)));
              emit(UploadTaskPhotosPickedImage());
            }
          } else {
            emit(ImageIsAlreadyExist());
          }
        }
      }
    } catch (e) {
      emit(UploadTaskPhotosFailure());
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        final fileName = basename(pickedImage.path);
        if (!existsImagesCheck.contains(fileName)) {
          if (existsImagesCheck.length < 6) {
            existsImagesCheck.add(fileName);
            imagesFiles.add(File(pickedImage.path));
            images.add(ImageBoxWithCloseIcon(filePath: File(pickedImage.path)));
            emit(UploadTaskPhotosPickedImage());
          }
        } else {
          emit(ImageIsAlreadyExist());
        }
      }
    } catch (e) {
      emit(UploadTaskPhotosFailure());
    }
  }

  removeImage(File image) {
    imagesFiles.removeWhere((file) => file?.path == image.path);
    existsImagesCheck.remove(basename(image.path));
    images.removeWhere((element) =>
        element is ImageBoxWithCloseIcon && element.filePath == image);
    emit(ImageRemoved());
  }

  void resetUploadTaskPhotosCubit() {
    imagesFiles.clear();
    if (images.length > 1) {
      images.removeRange(1, images.length);
    }
    existsImagesCheck.clear();
    emit(UploadTaskPhotosInitial());
  }
}
