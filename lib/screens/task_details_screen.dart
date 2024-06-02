import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_address_cubit/get_address_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_task_details_cubit/get_task_details_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/become_a_tasker_cubit/become_a_tasker_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_my_role_cubit/check_my_role_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:fix_flex/widgets/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import '../cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import '../widgets/image_box.dart';
import 'become_a_tasker_screen.dart';
import 'make_an_offer_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({Key? key});

  static const String id = 'TaskDetailsScreen';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<CheckMyRoleCubit,CheckMyRoleState>(
            builder: (context, state) {
              return BlocBuilder<GetTaskDetailsCubit, GetTaskDetailsState>(
                builder: (context, state) {
                  GetAddressCubit.get(context).getAddress(GetTaskDetailsCubit.get(context).state is GetTaskDetailsSuccess ? GetTaskDetailsCubit.get(context).state.taskDetailsList[0].location?.coordinates as List<dynamic> : [],);
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverAppBarWidget(
                              backgroundColor: kPrimaryColor,
                              onTap: () async {
                                await GetUserDataCubit.get(context).getUserData(
                                    state is GetTaskDetailsSuccess
                                        ? state.taskDetailsList[0].userId?.id as String
                                        : '');
                                CheckPersonalInformationCubit.get(context)
                                    .checkPersonalInformation(userId:
                                        state is GetTaskDetailsSuccess
                                            ? state.taskDetailsList[0].userId?.id as String
                                            : '');
                                Navigator.pushNamed(
                                    context, PersonalInformationScreen.id);
                              },
                              title: 'Task Details',
                              icon: Icons.arrow_back,
                              iconSize: 35,
                              onPressed: () {
                                BecomeATaskerCubit.get(context).resetBecomeATaskerCubit();
                                Navigator.pop(context);
                              },
                              image: state is GetTaskDetailsSuccess
                                  ? state.taskDetailsList[0].userId?.profilePicture?.url !=
                                          null
                                      ? state.taskDetailsList[0].userId?.profilePicture
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
                                          ? TaskDetailsScreenComponents(state,context)
                                          : Container(),
                        ),
                      ),
                    );
                },
              );
            }
          ),
      ),
    );
  }

  SingleChildScrollView TaskDetailsScreenComponents(
      GetTaskDetailsSuccess state ,context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Posted by : ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                      Container(
                        width: 120,
                        child: Text(
                            state.taskDetailsList[0].userId!.firstName! +
                                ' ' +
                                state.taskDetailsList[0].userId!.lastName!,
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
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location : ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),

                        BlocBuilder<GetAddressCubit,GetAddressState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: 220,
                              child: Text(
                                  GetAddressCubit.get(context).state is GetAddressSuccess ?
                                  '${GetAddressCubit.get(context).placemarks[0].subAdministrativeArea as String} In ${GetAddressCubit.get(context).placemarks[0].country as String}' :
                                      GetTaskDetailsCubit.get(context).state.taskDetailsList[0].location?.online == true ?'Online': 'No location',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    )),
                            );
                          }
                        ),

                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To be Done : ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                      Text(state.taskDetailsList[0].dueDate?.before != null?'Before ':state.taskDetailsList[0].dueDate?.on != null?'On':'',textAlign: TextAlign.center,
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
                                    ? ' ${DateFormat.yMMMMd().format(DateTime.parse(state.taskDetailsList[0].dueDate?.on as String))}'
                                    : ' ${DateFormat.yMMMMd().format(DateTime.parse(state.taskDetailsList[0].dueDate?.before as String))}',
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
                    state.taskDetailsList[0].userId?.id == SecureVariables.userId
                        ? Container()
                        : Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xff134161),
                            ),
                            child: Builder(builder: (context) {
                              return TextButton(
                                onPressed: () async {
                                  await CheckMyRoleCubit.get(context).checkMyRole();
                                  if(CheckMyRoleCubit.get(context).state is IamATasker){
                                    Navigator.pushNamed(context, MakeAnOfferScreen.id);
                                  }else if(CheckMyRoleCubit.get(context).state is IamAUser){
                                    Navigator.pushNamed(
                                        context, BecomeATaskerScreen.id);
                                  }

                                },
                                child: Text(
                                  'Make An Offer',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
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
                : state.taskDetailsList[0].images!.length <= 3
                    ? 135
                    : 270,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(8.0), // padding around the grid
              itemBuilder: (context, index) {
                return ImageBox(imageLink: state.taskDetailsList[0].images?[index].url as String,);
              },
              itemCount: state.taskDetailsList[0].images?.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
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
          state.taskDetailsList[0].offerDetails!.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          //tasker name
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: state
                                              .taskDetailsList[0]
                                              .offerDetails![index]
                                              .taskerId
                                              ?.userId
                                              ?.profilePicture!
                                              .url !=
                                          null
                                      ? NetworkImage(state
                                          .taskDetailsList[0]
                                          .offerDetails?[index]
                                          .taskerId
                                          ?.userId
                                          ?.profilePicture
                                          ?.url as String)
                                      : NetworkImage(kDefaultUserImage)
                                          as ImageProvider,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      state.taskDetailsList[0].offerDetails !=
                                              null
                                          ? state
                                                  .taskDetailsList[0]
                                                  .offerDetails![index]
                                                  .taskerId!
                                                  .userId!
                                                  .firstName! +
                                              ' ' +
                                              state
                                                  .taskDetailsList[0]
                                                  .offerDetails![index]
                                                  .taskerId!
                                                  .userId!
                                                  .lastName!
                                          : 'User',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      // state.taskDetailsList[0].offerDetails?[0].taskerId?.userId?.firstName as String,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  //tasker rating
                                  state.taskDetailsList[0].offerDetails?[index]
                                                  .taskerId?.ratingQuantity !=
                                              null &&
                                          state
                                                  .taskDetailsList[0]
                                                  .offerDetails?[index]
                                                  .taskerId
                                                  ?.ratingQuantity !=
                                              0
                                      ? Row(
                                          children: [
                                            RatingBarIndicator(
                                              itemBuilder: (context, index) {
                                                return Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                );
                                              },
                                              itemSize: 18,
                                              rating: state
                                                  .taskDetailsList[0]
                                                  .offerDetails![index]
                                                  .taskerId!
                                                  .ratingAverage!
                                                  .toDouble(),
                                            ),
                                            Text(
                                              '(${state.taskDetailsList[0].offerDetails![index].taskerId!.ratingQuantity})',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text('No rating'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      width: 270,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(11),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Offered Price: \$${state.taskDetailsList[0].offerDetails![index].price}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            ReadMoreText(
                                              state
                                                  .taskDetailsList[0]
                                                  .offerDetails![index]
                                                  .message as String,
                                              trimLength: 100,
                                              colorClickableText: Colors.blue,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: state.taskDetailsList[0].offerDetails!.length,
                )
              : Container(),
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


