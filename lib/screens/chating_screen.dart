import 'package:fix_flex/components/chat/message_box.dart';
import 'package:fix_flex/constants/constants.dart';
import 'package:fix_flex/cubits/chating_cubits/get_messages_by_chat_id_cubit/get_messages_by_chat_id_cubit.dart';
import 'package:fix_flex/cubits/chating_cubits/post_message_cubit/post_message_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/check_personal_information_cubit/check_personal_information_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/get_user_data_cubit/get_user_data_cubit.dart';
import 'package:fix_flex/models/message_model.dart';
import 'package:fix_flex/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';
import '../components/chat/chat_bubble.dart';
import '../helper/web_socket/socket_service.dart';
import '../widgets/sliver_appbar.dart';

class ChatingScreen extends StatelessWidget {
  ChatingScreen({
    super.key,
  });

  static const String id = 'ChatingScreen';
  final scrollController = ScrollController();
  final textEditingController = TextEditingController();
  static late String chatId;
  static late String taskerId;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    chatId = arguments['chatId'];
    taskerId = arguments['taskerId'];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              BlocBuilder<GetUserDataCubit, GetUserDataState>(
                  builder: (context, state) {
                    if(state is GetUserDataSuccess){
                      return SliverAppBarWidget(
                        backgroundColor: kPrimaryColor,
                        icon: Icons.arrow_back,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        chatImage: state.userDataList[0].profilePicture?.url != null
                            ? state.userDataList[0].profilePicture!.url as String : kDefaultUserImage,
                        onTap: () async {
                          await GetUserDataCubit.get(context)
                              .getUserData(taskerId);
                          await CheckPersonalInformationCubit.get(context)
                              .checkPersonalInformation(
                              userId: taskerId);
                          // await GetTaskerByIdCubit.get(context).getTaskerById(taskerId: taskerId);
                          Navigator.pushNamed(context, PersonalInformationScreen.id);
                        },
                        title: state.userDataList[0].FirstName + ' ' + state.userDataList[0].LastName,
                      );
                    }else{
                      return Container();
                    }
                  }
              ),
            ];
          },
          body: BlocBuilder<GetMessagesByChatIdCubit, GetMessagesByChatIdState>(
            builder: (context, state) {
              if (state is GetMessagesByChatIdLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetMessagesByChatIdFailure) {
                return Scaffold(
                  body: Center(
                    child: Text('Error occurred'),
                  ),
                );
              } else if (state is GetMessagesByChatIdSuccess && state.messagesList.isNotEmpty) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  scrollController.jumpTo(scrollController.position.maxScrollExtent);
                });

                return StreamBuilder(
                    stream: streamSocket.getResponse,
                    builder: (BuildContext context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                      final data = snapshot.data;
                      if (data != null) {
                        final messageModel = MessageModel.fromJson(data);
                        if(messageModel.chatId == chatId) {
                          state.messagesList.add(messageModel);
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            scrollController.jumpTo(scrollController.position.maxScrollExtent);
                          });
                        } else {
                          return const SizedBox();
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: state.messagesList.length,
                                itemBuilder: (context, index) {
                                  if (state.messagesList[index].sender == state.userId) {
                                    return SenderChatBubble(
                                      message: state.messagesList[index].message,
                                    );
                                  } else {
                                    return ReceiverChatBubble(
                                      message: state.messagesList[index].message,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                );
              } else if(state is GetMessagesByChatIdSuccess && state.messagesList.isEmpty){
                return const Center(
                  child: Text('No messages'),
                );
              }else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      BlocBuilder<GetMessagesByChatIdCubit, GetMessagesByChatIdState>(
          builder: (context,state) {
            return MessageBox(controller: textEditingController,onSubmitted: (String value) async {
              if (value.isNotEmpty) {
                await PostMessageCubit.get(context).postMessage(message: value, chatId: chatId);
                if(state is GetMessagesByChatIdSuccess && state.messagesList.isEmpty){
                  GetMessagesByChatIdCubit.get(context).getMessagesByChatId(chatId: chatId);
                } else if (state is GetMessagesByChatIdSuccess && state.messagesList.isNotEmpty) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    scrollController.jumpTo(scrollController.position.maxScrollExtent);
                  });
                }
                textEditingController.clear();
              }
            },);
          }
      ),
    );
  }
}
