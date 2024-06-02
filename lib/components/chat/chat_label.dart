import 'package:fix_flex/cubits/chating_cubits/get_my_chats_cubit/get_my_chats_cubit.dart';
import 'package:fix_flex/screens/chating_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../cubits/chating_cubits/get_chat_by_id_cubit/get_chat_by_id_cubit.dart';

class ChatLabel extends StatelessWidget {
  const ChatLabel({
    super.key,
    required this.chatHolderName,
    this.image,
    required this.chatId,
    required this.index,
  });
  final chatHolderName;
  final NetworkImage? image;
  final String chatId;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:11,bottom: 11,right: 30),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
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
                    backgroundImage: image != null ? image : NetworkImage(kDefaultUserImage)
                  ),
                ],
              ),
              // CircleAvatar(
              //   radius: 11.0,
              //   backgroundColor: Colors.white.withOpacity(0.8),
              // ),
              // const CircleAvatar(
              //   radius: 10.0,
              //   backgroundColor: Colors.green,
              // ),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                GetMyChatsCubit.get(context).index = index;
                await GetChatByIdCubit.get(context).getChatById(id: chatId);
                Navigator.pushNamed(context, ChatingScreen.id);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   SizedBox(
                    width: 215.0,
                    child: Text(
                      chatHolderName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //      const SizedBox(
                  //       width: 100.0,
                  //       child: Expanded(
                  //         child: Text(
                  //           'lastMessage',
                  //           // lastMessage,
                  //           maxLines: 1,
                  //           overflow: TextOverflow.ellipsis,
                  //         ),
                  //       ),
                  //     ),
                  //     // Container(
                  //     //   width: 5.0,
                  //     //   height: 5.0,
                  //     //   decoration: const BoxDecoration(
                  //     //     color: Colors.black,
                  //     //     shape:BoxShape.circle,
                  //     //   ),
                  //     // ),
                  //      Text("lastMessageTime"),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}