import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:fix_flex/widgets/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({Key? key});

  static const String id = 'TaskDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetTaskDetailsCubit, GetTaskDetailsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBarWidget(
                    onTap: () async{
                      await GetUserDataCubit.get(context).getUserData(state is GetTaskDetailsSuccess
                          ? state.taskDetailsList[0].userId.id
                          : '');
                      CheckPersonalInformationCubit.get(context)
                          .checkPersonalInformation(state is GetTaskDetailsSuccess
                              ? state.taskDetailsList[0].userId.id
                              : '');
                      Navigator.pushNamed(context, PersonalInformationScreen.id);
                    },
                    title: 'Task Details',
                    icon: Icons.arrow_back,
                    iconSize: 35,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    image: state is GetTaskDetailsSuccess
                        ? state.taskDetailsList[0].userId.profilePicture?.url !=
                                null
                            ? state.taskDetailsList[0].userId.profilePicture
                                ?.url as String
                            : kDefaultUserImage
                        : kDefaultUserImage,
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: state is GetTaskDetailsLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is GetTaskDetailsEmpty
                        ? Center(
                            child: Text('No data found'),
                          )
                        : state is GetTaskDetailsFailure
                            ? Center(
                                child: Text(
                                    'There was an error, Please try again later'),
                              )
                            : state is GetTaskDetailsSuccess
                                ? TaskDetailsScreenComponents(state)
                                : Container(),
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView TaskDetailsScreenComponents(
      GetTaskDetailsSuccess state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.taskDetailsList[0].status == 'CANCELLED'
              ? Center(
                  child: statusContainer(Colors.red, 'CANCELLED'),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    statusContainer(
                        state.taskDetailsList[0].status == 'OPEN'
                            ? Colors.blue
                            : Colors.grey,
                        'OPEN'),
                    statusContainer(
                        state.taskDetailsList[0].status == 'ASSIGNED'
                            ? Colors.orange
                            : Colors.grey,
                        'ASSIGNED'),
                    statusContainer(
                        state.taskDetailsList[0].status == 'COMPLETED'
                            ? Colors.green
                            : Colors.grey,
                        'COMPLETED'),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              state.taskDetailsList[0].title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w800,
                color: Color(0xff134161),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Posted by',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    Container(
                      width: 120,
                      child: Text(
                          state.taskDetailsList[0].userId.firstName +
                              ' ' +
                              state.taskDetailsList[0].userId.lastName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.grey,
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    Text(state.taskDetailsList[0].city as String,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Spacer(),
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.grey,
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('To be Done',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                    Container(
                      width: 120,
                      child: Text(
                          state.taskDetailsList[0].dueDate?.flexible == true
                              ? 'Flexible'
                              : state.taskDetailsList[0].dueDate?.on != null
                                  ? ' On ${DateFormat.yMMMMd().format(DateTime.parse(state.taskDetailsList[0].dueDate?.on as String))}'
                                  : ' Before: ${DateFormat.yMMMMd().format(DateTime.parse(state.taskDetailsList[0].dueDate?.before as String))}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Spacer(),
                    Text('Task Budget',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                    Spacer(),
                    Text(
                      '\$${state.taskDetailsList[0].budget}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    state.taskDetailsList[0].userId.id == SecureVariables.userId
                        ? Container()
                        : Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xff134161),
                              // color: Color(0xff222a32),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Make An Offer',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              state.taskDetailsList[0].details as String,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: state.taskDetailsList[0].images?.isEmpty == true
                ? 0
                : state.taskDetailsList[0].images!.length <= 4
                    ? 100
                    : state.taskDetailsList[0].images!.length <= 8
                        ? 200
                        : 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(8.0), // padding around the grid
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(48), // Image radius
                    child: Image.network(
                        state.taskDetailsList[0].images?[index].url as String,
                        fit: BoxFit.cover),
                  ),
                );
              },
              itemCount: state.taskDetailsList[0].images?.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Text(
              'Offers (${state.taskDetailsList[0].offerDetails?.length})',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }

  Container statusContainer(Color color, String text) {
    return Container(
      width: 110,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
