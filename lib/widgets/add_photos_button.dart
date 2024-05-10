import 'package:fix_flex/cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/add_task_photos.dart';

class AddPhotosButton extends StatelessWidget {
  const AddPhotosButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: Colors.white,
        offset: Offset(0, 0),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              onTap: () {
                UploadTaskPhotosCubit.get(context).pickImagesFromGallery();
              },
              // value: 'Gallery',
              child: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 10.0),
                  Text('Gallery'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              onTap: () {
                UploadTaskPhotosCubit.get(context).pickImageFromCamera();
              },
              // value: 'Camera',
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 10.0),
                  Text('Camera'),
                ],
              ),
            ),
          ];
        },
        child: Stack(
          children: [
            Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 50,
                color: Colors.grey[500],
              ),
            ),
          ),
            Positioned(
              right: 0,
              top: 0,
              child: Icon(
                Icons.add_circle,
                color: Colors.grey[500],
                size: 30,
              ),
            )
          ],
        ));
  }
}
