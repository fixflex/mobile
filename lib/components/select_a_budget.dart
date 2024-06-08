import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/map_cubit/map_cubit.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/date_radio_button_cubit/date_radio_button_cubit.dart';
import 'package:fix_flex/cubits/radio_buttons_cubit/place_radio_button_cubit/place_radio_button_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/details_cubit/details_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/post_task_cubit/post_task_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/title_cubit/title_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/upload_task_photos_cubit/upload_task_photos_cubit.dart';
import 'package:fix_flex/models/task_model.dart';
import 'package:fix_flex/screens/home%20page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import '../cubits/get_categories_cubit/get_categories_cubit.dart';
import '../cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import '../screens/post_a_task_screen.dart';

class SelectABudget extends StatelessWidget {
  const SelectABudget({super.key});

  static const String id = 'SelectABudget';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Budget'),
      ),
      body: NumKeyWidget(
        title: 'Select Budget',
        description: 'Just an estimate. You will finalize this later.',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<BudgetCubit,BudgetState>(
        builder: (context, state) {
          return BlocBuilder<PostTaskCubit,PostTaskState>(
            builder: (context, state) {
              return BlocBuilder<BudgetCubit,BudgetState>(
                builder: (context, state) {
                  return FloatingActionButtonInPostATask(
                    backgroundColor: state is LastBudget ? kPrimaryColor : Colors.grey,
                    text: 'Post The Task',
                    onPressed: () async {
                      if(state is LastBudget){
                        final TaskModel taskModel = TaskModel(
                          title:TitleCubit.get(context).titleController.text,
                          details: DetailsCubit.get(context).detailsController.text,
                          categoryId: GetCategoriesCubit.get(context).categoriesDataList[GetCategoriesCubit.get(context).clickedCategoryIndex].id,
                          dueDate: DueDate(
                            on :  DateRadioButtonCubit.get(context).state is OnDateRadioButtonsSelected ? DateFormat('yyyy-MM-dd').format(DateRadioButtonCubit.get(context).onDateSelected as DateTime): null,
                            before: DateRadioButtonCubit.get(context).state is BeforeDateRadioButtonsSelected ? DateFormat('yyyy-MM-dd').format(DateRadioButtonCubit.get(context).beforeDateSelected as DateTime) : null,
                            flexible: DateRadioButtonCubit.get(context).state is FlexibleDateRadioButtonsSelected ? true : false,
                          ),
                          location:Location(
                              online: PlaceRadioButtonCubit.get(context).state is OnlineSelected ? true : false,
                              coordinates: PlaceRadioButtonCubit.get(context).state is InPersonSelected ?[
                                MapCubit.taskPosition?.longitude,
                                MapCubit.taskPosition?.latitude
                              ]: null
                          ) ,
                          budget: int.parse(BudgetCubit.get(context).budgetController.text) ,
                        );
                        await PostTaskCubit.get(context).postTask(taskModel: taskModel,context: context);
                        if (state is PostTaskLoading || UploadTaskPhotosCubit.get(context).state is UploadTaskPhotosLoading){
                          showDialog(context: context,
                            builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: Center(child: CircularProgressIndicator()),
                            );
                          },);

                        }else if(PostTaskCubit.get(context).state is PostTaskSuccess){
                            showDialog(context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 1), () async {
                                  resetPostTaskFetcher(context);
                                    BottomNavigationBarCubit.get(context).changeBottomNavBar(3, context);
                                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                                });
                                  return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Icon(Icons.check_circle,color: Colors.green,size: 70,),
                                content: Text('Task created successfully',textAlign: TextAlign.center,),
                                contentTextStyle: TextStyle(fontSize: 18,color: Colors.black,),
                              );
                            },);

                        }else{
                          showDialog(context: context,
                            barrierDismissible: false,
                            builder: (context) {
                            Future.delayed(Duration(seconds: 1),()async{
                              Navigator.pop(context);
                            });
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Icon(Icons.error,color: Colors.red,size: 70,),
                              content: Text('Failed to create task',textAlign: TextAlign.center,),
                              contentTextStyle: TextStyle(fontSize: 18,color: Colors.black,),
                            );
                          },);
                        }
                      }else return null;
                    },
                  );
                }
              );
            }
          );
        }
      ),
    );
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

class NumKeyWidget extends StatelessWidget {
  const NumKeyWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final List<Widget> Buttons= [
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('1');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('2',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('2');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('3');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('4',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('4');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('5',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('5');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('6',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('6');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('7',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('7');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('8',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('8');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('9',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('9');
          },
        ),
      ),
      Container(),
      CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xff134161),
        child: IconButton(
          icon: Text('0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
          onPressed: () {
            BudgetCubit.get(context).addToBudget('0');
          },
        ),
      ),
      CircleAvatar(
        radius: 35,
        backgroundColor: Colors.transparent ,
        child: IconButton(
          icon: Icon(Icons.backspace_outlined,color: Color(0xff134161) ,size: 35),
          onPressed: () {
            BudgetCubit.get(context).removeFromBudget();
          },
        ),
      ),
    ];
    return BlocBuilder<BudgetCubit, BudgetState>(builder: (context, state) {
      final cubit = BudgetCubit.get(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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
                child:
                    Text(description,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15,
                        ))),
            //budget keyboard
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('\$${cubit.budgetController.text}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xff134161),
                            fontSize: 40,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            state is LessThenMinimumBudget?Center(child: Container(height : 20,child: Text('Minimum budget : \$10',style: TextStyle(color: Colors.red,fontSize: 18),))):Container(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: SizedBox(
                  height: 450,
                  width: 300,
                  child: GridView.builder(
                    controller: ScrollController(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) {
                        return Buttons[index];
                    },
                    itemCount: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}