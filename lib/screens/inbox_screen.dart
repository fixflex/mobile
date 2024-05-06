import 'package:fix_flex/components/chat_label.dart';
import 'package:flutter/material.dart';

class InBoxScreen extends StatelessWidget {
  const InBoxScreen ({super.key});

  static const String id = 'InBoxScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox'),),
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              ChatLabel(senderEmail: '', receiverName: 'Mostafa', receiverEmail: '')
            ],
          ),
        );
      },
      itemCount: 10,
      ),
    );
  }
}
