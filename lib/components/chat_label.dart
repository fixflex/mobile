import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ChatLabel extends StatelessWidget {
  const ChatLabel({
    super.key,
    required this.senderEmail,
    required this.receiverName,
    required this.receiverEmail,
    // required this.lastMessage,
    // required this.lastMessageTime,
  });
  final String senderEmail;
  final String receiverName ;
  final String receiverEmail ;
  // final String lastMessage ;
  // final String lastMessageTime ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:11,bottom: 11,right: 30),
      child: Row(
        children: [
          const SizedBox(width: 20.0,),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              const Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.grey,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:NetworkImage(kDefaultUserImage)
                  ),
                ],
              ),
              CircleAvatar(
                radius: 11.0,
                backgroundColor: Colors.white.withOpacity(0.8),
              ),
              const CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.green,
              ),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    width: 215.0,
                    child: Text(
                      receiverName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       const SizedBox(
                        width: 100.0,
                        child: Expanded(
                          child: Text(
                            'lastMessage',
                            // lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 5.0,
                      //   height: 5.0,
                      //   decoration: const BoxDecoration(
                      //     color: Colors.black,
                      //     shape:BoxShape.circle,
                      //   ),
                      // ),
                       Text("lastMessageTime"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}