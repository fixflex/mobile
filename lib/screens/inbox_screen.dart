import 'package:flutter/material.dart';

class InBoxScreen extends StatelessWidget {
  const InBoxScreen ({super.key});

  static const String id = 'InBoxScreen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox'),),
    );
  }
}
