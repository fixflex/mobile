import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/task_container.dart';
import '../cubits/tasks_cubits/search_task_cubit/search_task_cubit.dart';
import '../cubits/tasks_cubits/search_task_cubit/search_task_state.dart';
import '../models/task_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  static const String id = 'SearchScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("search")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller:
                    BlocProvider.of<TaskCubit>(context).searchController,
                onChanged: (value) {
                  BlocProvider.of<TaskCubit>(context).fetchData(query: value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            Expanded(
              child: BlocBuilder<TaskCubit, SearchTaskState>(
                builder: (context, state) {
                  if (state is TaskLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TaskSuccessState) {
                    if (state.tasks.isEmpty) {
                      return Center(
                        child: Text("No tasks found"),
                      );
                    } else {
                      final List<TaskModel> search = state.tasks;
                      return ListView.builder(
                        itemCount: search.length,
                        itemBuilder: (context, index) {
                          return TaskContainer(
                              title: search[index].title,
                              budget: search[index].budget,
                              location: search[index].city ?? "",
                              date: search[index].dueDate,
                              status: search[index].status ?? "",
                              offersId: search[index].offersId,
                              taskId: search[index].id ?? "");
                        },
                      );
                    }
                  } else if (state is TaskEmptyState) {
                    return Container(
                      child: Center(
                        child: Text("Please enter a search query"),
                      ),
                    );
                  } else if (state is TaskFailureState) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ));
  }
}
