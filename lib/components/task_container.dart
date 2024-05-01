import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/screens/task_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    super.key,
    required this.title,
    required this.budget,
    required this.location,
    required this.date,
    required this.status,
    required this.offersId,
    required this.taskId,
    this.backgroundImage,
  });

  final String title;
  final int budget;
  final String? location;
  final DueDate? date;
  final String status;
  final List<dynamic>? offersId;
  final String taskId;
  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {
          GetTaskDetailsCubit.get(context).getTaskDetails(taskId: taskId);
          Navigator.pushNamed(context, TaskDetailsScreen.id);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
                spreadRadius: 0.3,
                offset: Offset(0.7, 0.7),
              )
            ],
          ),
          width: double.infinity,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 230,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 80,
                      child: Text(
                        '\$${budget}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: CupertinoColors.inactiveGray,
                            ),
                            Text(
                              location!,
                              style: TextStyle(
                                fontSize: 15,
                                color: CupertinoColors.inactiveGray,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: CupertinoColors.inactiveGray,
                            ),
                            Text(
                              date?.flexible == true
                                  ? 'flexible'
                                  : date?.on != null
                                      ? ' ON ${DateFormat.yMMMMd().format(DateTime.parse(date!.on!))}'
                                      : ' Before: ${DateFormat.yMMMMd().format(DateTime.parse(date!.before!))}'
                              ,
                              style: TextStyle(
                                fontSize: 15,
                                color: CupertinoColors.inactiveGray,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              status,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: status == 'OPEN'
                                    ? Colors.blue
                                    : status == 'CANCELLED'
                                        ? Colors.red
                                        : status == 'COMPLETED'
                                            ? Colors.green
                                            : status == 'ASSIGNED'
                                                ? Colors.orange
                                                : Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              // 'Offers',
                              offersId?.length == 0
                                  ? 'No Offers':'${offersId?.length} Offers',
                                style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CupertinoColors.inactiveGray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.grey,
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: backgroundImage,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
