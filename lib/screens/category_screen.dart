import 'package:fix_flex/cubits/get_categories_cubit/get_categories_cubit.dart';
import 'package:fix_flex/cubits/tasks_cubits/get_tasks_by_category_id_cubit/get_tasks_by_category_id_cubit.dart';
import 'package:fix_flex/screens/make_task_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/task_container.dart';
import '../constants/constants.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String id = 'categoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          GetCategoriesCubit.get(context)
              .categoriesDataList[
                  GetCategoriesCubit.get(context).clickedCategoryIndex]
              .name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocBuilder<GetTasksByCategoryIdCubit, GetTasksByCategoryIdState>(
        builder: (context, state) {
          if (state is GetTasksByCategoryIdLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetTasksByCategoryIdEmpty) {
            return Center(child: Text('No tasks available'));
          } else if (state is GetTasksByCategoryIdFailure) {
            return Center(child: Text('Failed to load tasks'));
          } else if (state is GetTasksByCategoryIdSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return TaskContainer(
                    title: state.tasksDataList[index].title,
                    budget: state.tasksDataList[index].budget,
                    offersId: state.tasksDataList[index].offersId,
                    location: state.tasksDataList[index].city,
                    date: state.tasksDataList[index].dueDate,
                    status: state.tasksDataList[index].status,
                    taskId: state.tasksDataList[index].id,
                    backgroundImage: NetworkImage(
                      state.tasksDataList[index].userId.profilePicture?.url != null
                          ? state.tasksDataList[index].userId.profilePicture?.url as String
                          : kDefaultUserImage,
                    ));
              },
              itemCount: state.tasksDataList.length,
            );
          } else {
            return Center(child: Text('Failed to load tasks'));
          }
        },
      ),
      floatingActionButton:SizedBox(
        width: 65,
        height: 65,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, MakeTaskRequestScreen.id );
            },
            backgroundColor: kPrimaryColor,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
