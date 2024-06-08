import 'package:fix_flex/components/chat/chat_label.dart';
import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:fix_flex/helper/secure_storage/secure_keys/secure_variable.dart';
import 'package:fix_flex/helper/web_socket/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InBoxScreen extends StatelessWidget {
   InBoxScreen({super.key});

  static const String id = 'InBoxScreen';
  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: BlocBuilder<GetMyChatsCubit, GetMyChatsState>(
        builder: (context, state) {
          if (state is GetMyChatsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetMyChatsFailure) {
            return const Center(
              child: Text('Failed to load chats'),
            );
          } else if (state is GetMyChatsSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: StreamBuilder(
                stream: streamSocket.getChatRoom,
                builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                  final data = snapshot.data;
                  if (data != null) {
                    // final myChatsDataModel = MyChatsDataModel.fromJson(data);
                    // GetMyChatsCubit.get(context).fetchUserData(context, myChatsDataModel.tasker);
                    // state.myChatsDataModel.add(myChatsDataModel);
                    // GetMyChatsCubit.get(context).getMyChats(context);
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      scrollController.jumpTo(scrollController.position.minScrollExtent);
                    });
                  }
                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: state.chatsHolders.length,
                    itemBuilder: (context, index) {
                      final String taskerId = state.myChatsDataModel[index].user == SecureVariables.userId ? state.myChatsDataModel[index].tasker : state.myChatsDataModel[index].user;
                      return ChatLabel(
                        index: index,
                        chatId: state.myChatsDataModel[index].id,
                        taskerId: taskerId,
                        image: state.chatsHolders[index].profilePicture?.url != null
                            ? NetworkImage(state.chatsHolders[index].profilePicture!.url as String) : null,

                        chatHolderName: '${state.chatsHolders[index].FirstName} ${state.chatsHolders[index].LastName}',
                      );
                    },
                  );
                }
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
