import 'package:fix_flex/components/task_container.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_user_id/get_tasks_by_user_id_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String id = 'OrdersScreen';

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
            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskContainer(
                  title: state.MyTasksList[index].title,
                  budget: state.MyTasksList[index].budget,
                  offersId: state.MyTasksList[index].offersId,
                  location: state.MyTasksList[index].city != null && state.MyTasksList[index].city != ''
                      ? state.MyTasksList[index].city as String
                      : 'No location',
                  date: state.MyTasksList[index].dueDate,
                  status: state.MyTasksList[index].status,
                  taskId: state.MyTasksList[index].id,
                  backgroundImage: NetworkImage( state.MyTasksList[index].userId.profilePicture?.url != null
                      ? state.MyTasksList[index].userId.profilePicture?.url as String : kDefaultUserImage,
                  ),
                );
              },
              itemCount: state.MyTasksList.length,
            );
          }
          return const SizedBox();

        },
      ),
    );
  }
}
