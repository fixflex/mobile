import 'package:fix_flex/components/task_container.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'package:fix_flex/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/constants.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_address_cubit/get_address_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String id = 'OrdersScreen';

  Future<List<String>> fetchAddresses(BuildContext context, List<TaskModel> tasks) async {
    final addresses = <String>[];

    for (var task in tasks) {
      if (task.location != null) {
        await GetAddressCubit.get(context).getAddress(task.location?.coordinates);
        final addressState = GetAddressCubit.get(context).state;
        if (addressState is GetAddressSuccess) {
          addresses.add(GetAddressCubit.get(context).placemarks[0].subAdministrativeArea ?? 'No location');
        } else {
          addresses.add('Online');
        }
      } else {
        addresses.add('No location');
      }
    }

    return addresses;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: BlocBuilder<GetTasksByUserIdCubit, GetTasksByUserIdState>(
        builder: (context, state) {
          if (state is GetTasksByUserIdLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetTasksByUserIdEmpty) {
            return Center(child: Text('No tasks available'));
          } else if (state is GetTasksByUserIdFailure) {
            return Center(child: Text('Failed to load tasks'));
          } else if (state is GetTasksByUserIdSuccess) {
            return FutureBuilder<List<String>>(
              future: fetchAddresses(context, state.MyTasksList),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load addresses'));
                } else {
                  final addresses = snapshot.data ?? [];
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskContainer(
                        title: state.MyTasksList[index].title,
                        budget: state.MyTasksList[index].budget,
                        offersId: state.MyTasksList[index].offersId,
                        location: addresses[index],
                        date: state.MyTasksList[index].dueDate,
                        status: state.MyTasksList[index].status as String,
                        taskId: state.MyTasksList[index].id as String,
                        backgroundImage: NetworkImage(
                          state.MyTasksList[index].userId?.profilePicture?.url != null
                              ? state.MyTasksList[index].userId?.profilePicture?.url as String
                              : kDefaultUserImage,
                        ),
                      );
                    },
                    itemCount: state.MyTasksList.length,
                  );
                }
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
