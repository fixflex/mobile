import 'package:fix_flex/components/select_a_budget.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/post_a_task_screen.dart';

class AddTaskPhotos extends StatelessWidget {
  const AddTaskPhotos({super.key});

  static const String id = 'AddTaskPhotos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task Photos'),
      ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('Snap a Photo',
              style: GoogleFonts.abel(
                  textStyle: TextStyle(
                    color: Color(0xff134161),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ))),
          Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 15),
              child: Text('Help Taskers understand what needs doing. Add up to 6 photos.',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15,
                  ))),
          //photos
          SizedBox(
            height: 450,
            child: BlocConsumer<UploadTaskPhotosCubit,UploadTaskPhotosState>(
              listener: (context, state) {
                if(state is ImageIsAlreadyExist){
                  Fluttertoast.showToast(
                      msg: 'Image is already exist',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }

              },
              builder: (context, state) {
                return GridView.builder(
                  itemBuilder: (context, index) {
                    if(UploadTaskPhotosCubit.get(context).images.length<=6){
                      return  UploadTaskPhotosCubit.get(context).images[index];
                    }else{
                      return UploadTaskPhotosCubit.get(context).images[index+1];
                    }
                  },
                  itemCount: UploadTaskPhotosCubit.get(context).images.length<=6 ? UploadTaskPhotosCubit.get(context).images.length:UploadTaskPhotosCubit.get(context).images.length-1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                  ),
                );
              }
            ),
          ),
        ],
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: BlocBuilder<UploadTaskPhotosCubit,UploadTaskPhotosState>(
      builder: (context, state) {
        return FloatingActionButtonInPostATask(
          backgroundColor: kPrimaryColor,
        text: UploadTaskPhotosCubit.get(context).imagesFiles.isNotEmpty?'Continue':'Skip for now',
        onPressed: () {
        Navigator.pushNamed(context, SelectABudget.id);
        },);
      }
    ),
    );
  }
}


