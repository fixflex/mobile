import 'dart:io';
import 'package:flutter/material.dart';
import '../cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'image_box.dart';

class ImageBoxWithCloseIcon extends StatelessWidget {
  const ImageBoxWithCloseIcon({
    super.key,
    required this.filePath,
  });

  final File filePath;

  @override
  Widget build(BuildContext context) {
    return ImageBox(
      fileImage: true,
      filePath: filePath,
      closeIcon: IconButton(
        icon: Stack(
            alignment:Alignment.center ,
            children: [
          // Icon(Icons.circle, color: Colors.white, size: 30),
          Icon(Icons.circle, color: Colors.red, size: 30),
          Icon(Icons.close, color: Colors.white, size: 17),
        ]),
        onPressed: () {
          UploadTaskPhotosCubit.get(context).removeImage(filePath);
        },
      ),);
  }
}