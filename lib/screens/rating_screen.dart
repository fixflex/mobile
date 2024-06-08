import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/rate_tasker_cubit/rate_tasker_cubit.dart';
import 'package:fix_flex/screens/post_a_task_screen.dart';
import 'package:fix_flex/screens/task_details_screen.dart';
import 'package:fix_flex/widgets/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  static const String id = 'RatingScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBarWidget(
                title: 'Rating',
                icon: Icons.arrow_back,
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: kPrimaryColor,
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text('Rate the tasker',
                    style: GoogleFonts.abel(
                        textStyle: TextStyle(
                          color: Color(0xff134161),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 30),
                    child: Text('Rate the tasker out of 5 stars',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 15,
                        ))),
                Center(
                  child: Container(
                    child: RatingBar.builder(
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      itemSize: 50,
                      allowHalfRating: true,
                      initialRating: 0.0,
                      minRating: 0.5,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      onRatingUpdate: (double value) {
                        RateTaskerCubit.get(context).setRate(value);
                        print('Rating is: $value');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocListener<RateTaskerCubit, RateTaskerState>(
        listener: (context, state) {
          if (state is RateTaskerSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.popUntil(context, ModalRoute.withName(TaskDetailsScreen.id));
                });
                return AlertDialog(
                  title:  Icon(Icons.check_circle, color: Colors.green, size: 70,),
                  content: Text('Thank you for rating the tasker'),
                );
              },
            );
          }
          else if (state is RateTaskerFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Icon(Icons.error, color: Colors.red,size: 70,),
                  content: Text('Failed to submit rating, please try again later'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
          else if (state is AlreadyReviewed) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.popUntil(context, ModalRoute.withName(TaskDetailsScreen.id));
                });
                return AlertDialog(
                  title:  Icon(Icons.check_circle, color: Colors.green, size: 70,),
                  content: Text('You have already rated this tasker'),
                );
              },
            );
          }
        },
        child: BlocBuilder<RateTaskerCubit,RateTaskerState>(
          builder: (context, state) {
            return BlocBuilder<GetTaskDetailsCubit, GetTaskDetailsState>(
              builder: (context, state) {
                return FloatingActionButtonInPostATask(
                  backgroundColor: kPrimaryColor,
                  text: RateTaskerCubit.get(context).state is AddNewRate ?'Post Rating':'Skip For Now',
                  onPressed: () async {
                    if (state is GetTaskDetailsSuccess) {
                      await RateTaskerCubit.get(context).rateTasker(
                        taskId: state.taskDetailsList[0].id as String,
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                );
              },
            );
          }
        ),
      ),
    );
  }
}
