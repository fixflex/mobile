import 'package:fix_flex/components/choose_time_of_task.dart';
import 'package:fix_flex/components/default_form_field.dart';
import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/date_radio_button_cubit/date_radio_button_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/details_cubit/details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constants.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import '../cubits/radio_buttons_cubit/place_radio_button_cubit/place_radio_button_cubit.dart';
import '../cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/tasks_cubits/title_cubit/title_cubit.dart';
import '../models/task_model.dart';

class PostATaskScreen extends StatelessWidget {
  const PostATaskScreen({super.key});

  static const String id = 'PostATaskScreen';

  @override
  Widget build(BuildContext context) {
    Future<bool> _popScope() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Discard Task?'),
          content: Text('Are you sure you want to discard this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                resetPostTaskFetcher(context);
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _popScope,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Post ${GetCategoriesCubit.get(context).categoriesDataList[GetCategoriesCubit.get(context).clickedCategoryIndex].name} Task',
            style: TextStyle(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text('Start With a Title',
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                      color: Color(0xff134161),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Text('In a few words, what do you need done?',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15,
                        ))),
                //title TFF
                BlocBuilder<TitleCubit, TitleState>(builder: (context, state) {
                  var cubit = TitleCubit.get(context);
                  return defaultFormField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {
                      cubit.changeTitleText();
                    },
                    maxLength: 50,
                    maxLines: 1,
                    counterText: cubit.state is TitleMaxTextChange
                        ? 'Maximum 50 characters'
                        : '',
                    width: double.infinity,
                    hint: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.grey[300],
                    controller: cubit.titleController,
                    keyType: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty || value.length < 10) {
                        return 'Minimum 10 characters';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                  );
                }),
                SizedBox(height: 30),
                DetailsBoxWidget(
                  title: 'Describe the task',
                  description: 'Summarize the task in more detail',
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            BlocBuilder<TitleCubit, TitleState>(builder: (context, state) {
          return BlocBuilder<DetailsCubit,DetailsState>(
            builder: (context, state) {
              return FloatingActionButtonInPostATask(
                backgroundColor: TitleCubit.get(context).titleController.text.length < 10 || DetailsCubit.get(context).detailsController.text.length < 25
                    ? Colors.grey
                    : kPrimaryColor,
                text: 'Continue',
                onPressed: () {
                  TitleCubit.get(context).titleController.text.length < 10 || DetailsCubit.get(context).detailsController.text.length < 25
                    ? null:Navigator.pushNamed(context, ChooseTimeOfTask.id);
                },
              );
            }
          );
        }),
      ),
    );
    // Display selected image
  }

  void resetPostTaskFetcher(BuildContext context) {
    TitleCubit.get(context).resetTitleCubit();
    DetailsCubit.get(context).resetDetailsCubit();
    DateRadioButtonCubit.get(context).resetDateRadioButtonCubit();
    PlaceRadioButtonCubit.get(context).resetPlaceRadioButtonCubit();
    MapCubit.get(context).resetLocationCubit(context);
    UploadTaskPhotosCubit.get(context).resetUploadTaskPhotosCubit();
    BudgetCubit.get(context).resetBudgetCubit();
    PostTaskCubit.get(context).resetPostTaskCubit();
  }
}

class DetailsBoxWidget extends StatelessWidget {
  const DetailsBoxWidget({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.abel(
                textStyle: TextStyle(
              color: Color(0xff134161),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ))),
        Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 15),
            child: Text(description,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15,
                ))),
        //details TFF
        BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
          var cubit = DetailsCubit.get(context);
          return defaultFormField(
            onChanged: (value) {
              cubit.changeDetailsText();
            },
            autoValidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 8000,
            maxLines: 10,
            counterText: cubit.state is DetailsMaxTextChange
                ? 'Maximum 8000 characters'
                : '',
            width: double.infinity,
            hint: 'Details',
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey[300],
            controller: cubit.detailsController,
            keyType: TextInputType.text,
            validate: (String? value) {
              if (value!.isEmpty || value.length < 25) {
                return 'Minimum 25 characters';
              }
              return null;
            },
            prefix: Icons.padding,
          );
        }),
      ],
    );
  }
}

class FloatingActionButtonInPostATask extends StatelessWidget {
  const FloatingActionButtonInPostATask(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor});

  final String text;
  final void Function() onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 60,
        child: FloatingActionButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}